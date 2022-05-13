//
//  CartManager.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 13/05/2022.
//

import Combine
import Foundation

final class CartManager: ObservableObject {
    
    /// The service used to handle requests that perform cart operations.
    private let cartService: CartServiceProtocol
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Cart cartContents
    /// The entries in the cart.
    @Published private(set) var cartContents = [Cart.Entry]()
    
    /// Tracks whether the cart is currently being modified.
    @Published var isModifying = false
    
    @Published private(set) var error: String?
    
    // MARK: - Initializer
    /// Creates the cart.
    /// - Parameter cartService: An instance of a type that conforms to `CartServiceProtocol`.
    ///                          The default value is the return of the create method defined on `CartServiceFactory`.
    init(cartService: CartServiceProtocol = CartServiceFactory.create()) {
        self.cartService = cartService
    }
}

extension CartManager {
    /// Fetches the cartContents of the cart.
    /// On success, the decoded cart entries are assigned to `cartContents`.
    func fetchContents() {
        cartService.fetchCart()
            .retry(3)
            .receive(on: RunLoop.main)
            .catch { error ->  AnyPublisher<[Cart.Entry], Never> in
                self.error = error.description
                return Just([Cart.Entry]())
                    .eraseToAnyPublisher()
            }
            .sink {  [weak self] cartContents in
                self?.cartContents = cartContents
            }
            .store(in: &cancellables)
    }
    
    /// Adds an entry to the cart.
    /// - Parameters:
    ///   - food: The food item to add to the cart.
    ///   - quantity: The quantity of the food to add to the cart.
    func add(_ food: Food, options: [Option], quantity: Int) {
        isModifying = true
        cartService.addToCart(food, options: options, quantity: quantity)
            .retry(3)
            .receive(on: RunLoop.main)
            .catch { [weak self] error ->  AnyPublisher<Cart.Entry?, Never> in
                self?.error = error.description
                self?.isModifying = false
                return Just(nil)
                    .eraseToAnyPublisher()
            }
            .sink {  [weak self] cartEntry in
                guard let cartEntry = cartEntry else { return }
                self?.cartContents.append(cartEntry)
                print("ITEM ADDED", food.id)
                self?.isModifying = false
            }
            .store(in: &cancellables)
    }
    
    /// Removes an entry from the cart.
    /// - Parameter food: The food item to remove from the cart.
    func remove(_ food: Food) {
        isModifying = true
        if let index = cartContents.firstIndex(where: { $0.food.id == food.id }) {
            print("REMOVING ITEM")
            cartService.removeFromCart(cartContents[index])
                .retry(3)
                .receive(on: RunLoop.main)
                .catch { [weak self] error ->  AnyPublisher<UUID?, Never> in
                    self?.error = error.description
                    return Just(nil)
                        .eraseToAnyPublisher()
                }
                .sink {  [weak self] foodID in
                    guard foodID == food.id else { return }
                    
                    self?.cartContents.remove(at: index)
                    self?.isModifying = false
                }
                .store(in: &cancellables)
        } else {
            print("FAILED TO GET ITEM")
        }
    }
    
    /// Checks whether an entry containing the food item exists in the cart.
    /// - Parameter food: The food item to check an entry for.
    /// - Returns: A boolean indicating whether an entry containing the food item exists or not.
    func contains(_ food: Food) -> Bool {
        cartContents.contains(where: {$0.food.id == food.id})
    }
    
    
    func selectedOptions(for food: Food) -> [Option] {
        if let entry = cartContents
            .first(where: {$0.food.id == food.id}) {
            print("OPTIONS FOUND", entry.options)
            return entry.options
        }
        return [Option]()
    }
}
