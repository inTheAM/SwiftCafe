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

    func fetchContents() -> AnyPublisher<[Cart.Entry], CartError> {
        networkManager
            .makeRequestPublisher(endpoint: .fetchCartContents)
            .mapError { _ in
                return .failedToFetchContents
            }
            .eraseToAnyPublisher()
    }

    func addToCart(_ food: Food, quantity: Int) -> AnyPublisher<Cart.Entry?, CartError> {
        let entry = Cart.Entry.CreateData(foodID: food.id, quantity: quantity)

        return networkManager
            .makeRequestPublisher(endpoint: .addItemToCart, payload: entry)
            .mapError { _ in
                return .failedToAddItem
            }
            .eraseToAnyPublisher()

    }

    func removeFromCart(_ cartEntry: Cart.Entry) -> AnyPublisher<UUID?, CartError> {
        let payload = Cart.Entry.RemoveData(id: cartEntry.id)

        return networkManager
            .makeRequestPublisher(endpoint: .removeItemFromCart, payload: payload)
            .map { _ in
                return cartEntry.food.id
            }
            .mapError { _ in
                return .failedToRemoveItem
            }
            .eraseToAnyPublisher()
    }
}
