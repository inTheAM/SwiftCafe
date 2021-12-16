//
//  Cart.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation

/// #The user's cart.
final class Cart: ObservableObject {

    /// The service used to handle requests that perform cart operations.
    private let cartService: CartServiceProtocol

// MARK: - Cart contents
    /// The entries in the cart.
    @Published var contents = [Cart.Entry]()

    /// The loading state of the cart.
    @Published var isLoading = false

    /// Tracks whether the cart is currently being modified.
    @Published var isModifying = false

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
        isLoading = true
        cartService.fetchContents { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contents):
                    self?.contents  =   contents
                    self?.isLoading = false

                case .failure:
                    self?.isLoading = false
                }
            }
        }
    }

    /// Adds an entry to the cart.
    /// - Parameters:
    ///   - food: The food item to add to the cart.
    ///   - quantity: The quantity of the food to add to the cart.
    func add(_ food: Food, quantity: Int) {
        isModifying = true
        cartService.addToCart(food, quantity: quantity) { [weak self] result in
            switch result {
            case .success(let cartEntry):
                    self?.contents.append(cartEntry)
                    self?.isModifying = false
            case .failure:
                self?.isModifying = false
            }
        }
    }

    /// Removes an entry from the cart.
    /// - Parameter food: The food item to remove from the cart.
    func remove(_ food: Food) {
        isModifying = true
        if let index = contents.firstIndex(where: { $0.food.id == food.id }) {
            cartService.removeFromCart(contents[index]) { [weak self] result in
                switch result {
                case .success:
                    self?.contents.remove(at: index)
                    self?.isModifying = false
                case .failure:
                    self?.isModifying = false
                }
            }
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

        /// The quantity of the food item in the entry.
        let quantity: Int
    }
}

extension Cart.Entry {

    /// The data used to create a cart entry.
    struct CreateData: Encodable {

        /// The identifier for the food item to create an entry for.
        let foodID: UUID

        /// The quantity of the food item in the entry.
        let quantity: Int
    }

    /// The data used to remove a cart entry.
    struct RemoveData: Encodable {
        let id: UUID
    }
}
