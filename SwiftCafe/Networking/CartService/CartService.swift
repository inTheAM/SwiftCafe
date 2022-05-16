//
//  CartService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//
import Combine
import Foundation

/// #A service that handles the crud operations for the user's cart.
struct CartService: CartServiceProtocol {
    private let networkManager: NetworkManager = NetworkManager()

    func fetchCart() -> AnyPublisher<[Cart.Entry], CartError> {
        networkManager
            .makeRequestPublisher(endpoint: .fetchCart, payload: nil)
            .mapError { _ in
                return .failedToFetchContents
            }
            .map(\.contents)
            .eraseToAnyPublisher()
    }

    func addToCart(_ food: Food, options: [Option], quantity: Int) -> AnyPublisher<Cart.Entry?, CartError> {
        let optionIDs = options.map { $0.id }
        let entry = Cart.Entry.CreateData(foodID: food.id, options: optionIDs, quantity: quantity)

        return networkManager
            .makeRequestPublisher(endpoint: .addItemToCart, payload: entry)
            .mapError { _ in
                return .failedToAddItem
            }
            .eraseToAnyPublisher()

    }

    func removeFromCart(_ cartEntry: Cart.Entry) -> AnyPublisher<UUID?, CartError> {
        let payload = Cart.Entry.RemoveData(cartEntryID: cartEntry.id)

        return networkManager
            .makeRequestPublisher(endpoint: .removeItemFromCart, payload: payload)
            .map { result -> UUID? in
                switch result {
                case .success:
                    return cartEntry.food.id
                case .failure:
                    return nil
                }
            }
            .mapError { _ in
                return .failedToRemoveItem
            }
            .eraseToAnyPublisher()
    }
}
