//
//  Cart.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Combine
import Foundation

/// #The user's cart.
final class Cart: ObservableObject {

    /// The service used to handle requests that perform cart operations.
    private let cartService: CartServiceProtocol

    private var cancellables: Set<AnyCancellable> = .init()

// MARK: - Cart contents
    /// The entries in the cart.
    @Published var contents = [Cart.Entry]()

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

extension Cart {
    /// Fetches the contents of the cart.
    /// On success, the decoded cart entries are assigned to `contents`.
    func fetchContents() {
        cartService.fetchContents()
            .retry(3)
            .receive(on: RunLoop.main)
            .catch { error ->  AnyPublisher<[Cart.Entry], Never> in
                self.error = error.description
                return Just([Cart.Entry]())
                    .eraseToAnyPublisher()
            }
            .sink {  [weak self] contents in
                self?.contents = contents
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
            .catch { error ->  AnyPublisher<Cart.Entry?, Never> in
                self.error = error.description
                return Just(nil)
                    .eraseToAnyPublisher()
            }
            .sink {  [weak self] cartEntry in
                guard let cartEntry = cartEntry else { return }
                self?.contents.append(cartEntry)
                print("ITEM ADDED", food.id)
                self?.isModifying = false
            }
            .store(in: &cancellables)
    }

    /// Removes an entry from the cart.
    /// - Parameter food: The food item to remove from the cart.
    func remove(_ food: Food) {
        isModifying = true
        if let index = contents.firstIndex(where: { $0.food.id == food.id }) {
            print("REMOVING ITEM")
            cartService.removeFromCart(contents[index])
                .retry(3)
                .receive(on: RunLoop.main)
                .catch { [weak self] error ->  AnyPublisher<UUID?, Never> in
                    self?.error = error.description
                    return Just(nil)
                        .eraseToAnyPublisher()
                }
                .sink {  [weak self] foodID in
                    guard foodID == food.id else { return }

                    self?.contents.remove(at: index)
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
        contents.contains(where: {$0.food.id == food.id})
    }
}

extension Cart {
    /// #An entry in the cart.
    struct Entry: Identifiable, Decodable {

        /// The permanent identifier for the cart entry.
        let id: UUID

        /// The food item in the cart entry.
        let food: Food

        /// The options selected
        let options: [Option]

        /// The quantity of the food item in the entry.
        let quantity: Int
    }
}

extension Cart.Entry {
    typealias Quantity = Int
    /// The data used to create a cart entry.
    struct CreateData: Encodable {

        /// The identifier for the food item to create an entry for.
        let foodID: Food.ID

        /// The options selected
        let options: [Option.ID]

        /// The quantity of the food item in the entry.
        let quantity: Quantity
    }

    /// The data used to remove a cart entry.
    struct RemoveData: Encodable {

        /// The id of the cart entry to remove from the user's cart.
        let id: Cart.Entry.ID
    }
}
