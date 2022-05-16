//
//  MockCartService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Combine
import Foundation
@testable import SwiftCafe

/// #A mock implementation of `CartService`.
struct MockCartService: CartServiceProtocol {
    
    func clearCartContents() -> AnyPublisher<RequestResult, CartError> {
        return Just(.success)
            .setFailureType(to: CartError.self)
            .eraseToAnyPublisher()
    }

    /// Mocks fetching cart cartContents by passing sample cart entries.
    /// - Parameter completion: A closure the method runs to pass the sample cart entries.
    ///                         The closure takes an array of `Cart.Entry`.
    func fetchCart() -> AnyPublisher<[Cart.Entry], CartError> {
        Just(Cart.Entry.samples)
            .setFailureType(to: CartError.self)
            .eraseToAnyPublisher()
    }

    /// Mocks adding an item to the cart.
    /// - Parameters:
    ///   - food: The food item to test adding to the cart.
    ///   - quantity: The quantity to add.
    ///   - completion: A closure the method runs to mock a successful addition.
    ///                 The closure takes a Result that contains a `Cart.Entry`.
    func addToCart(_ food: Food, options: [Option], quantity: Int) -> AnyPublisher<Cart.Entry?, CartError> {
        let entry = Cart.Entry(id: UUID(), food: food, options: [Option](), quantity: quantity)
        return Just(entry)
            .setFailureType(to: CartError.self)
            .eraseToAnyPublisher()

    }

    /// Mocks removing an item from the cart.
    /// - Parameters:
    ///   - cartEntry: The entry to remove.
    ///   - completion: A closure the method runs to mock a successful deletion.
    ///                 The closure takes no parameters.
    func removeFromCart(_ cartEntry: Cart.Entry) -> AnyPublisher<UUID?, CartError> {
        Just(cartEntry.food.id)
            .setFailureType(to: CartError.self)
            .eraseToAnyPublisher()
    }
}
