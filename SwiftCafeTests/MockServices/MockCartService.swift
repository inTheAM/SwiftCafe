//
//  MockCartService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation
@testable import SwiftCafe

/// #A mock implementation of `CartService`.
struct MockCartService: CartServiceProtocol {

    /// Mocks fetching cart contents by passing sample cart entries.
    /// - Parameter completion: A closure the method runs to pass the sample cart entries.
    ///                         The closure takes an array of `Cart.Entry`.
    func fetchContents(completion: @escaping (Result<[Cart.Entry], RequestError>) -> Void) {
        completion(.success(Cart.Entry.samples))
    }

    /// Mocks adding an item to the cart.
    /// - Parameters:
    ///   - food: The food item to test adding to the cart.
    ///   - quantity: The quantity to add.
    ///   - completion: A closure the method runs to mock a successful addition.
    ///                 The closure takes a Result that contains a `Cart.Entry`.
    func addToCart(_ food: Food, quantity: Int, completion: @escaping (Result<Cart.Entry, RequestError>) -> Void) {
        let entry = Cart.Entry(id: UUID(), food: food, quantity: quantity)
        completion(.success(entry))
    }

    /// Mocks removing an item from the cart.
    /// - Parameters:
    ///   - cartEntry: The entry to remove.
    ///   - completion: A closure the method runs to mock a successful deletion.
    ///                 The closure takes no parameters.
    func removeFromCart(_ cartEntry: Cart.Entry, completion: @escaping (Result<Void, RequestError>) -> Void) {
        completion(.success(()))
    }
}
