//
//  CartServiceProtocol.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// A protocol for services that manage requests that involve cart operations.
protocol CartServiceProtocol {

    /// A type representing a closure that takes a result containing either an array of Cart.Entry or a RequestError.
    /// The closure returns nothing.
    typealias ContentsHandler = (Result<[Cart.Entry], RequestError>) -> Void

    /// A type representing a closure that takes a result containing either a single Cart.Entry or a RequestError.
    /// The closure returns nothing.
    typealias AddItemHandler = (Result<Cart.Entry, RequestError>) -> Void

    /// A type representing a closure that takes a result containing either nothing or a RequestError.
    /// The closure returns nothing.
    typealias RemoveItemHandler = (Result<Void, RequestError>) -> Void

    /// Fetches the contents of the user's cart.
    /// - Parameters:
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes the result of the request which may be
    ///                 an array of Cart.Entry or a RequestError.
    func fetchContents(completion: @escaping ContentsHandler)

    /// Adds an item to the user's cart.
    /// - Parameters:
    ///   - food: The item to add to the user's cart.
    ///   - quantity: The quantity of the item to add to the user's cart.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes the result of the request which may be
    ///                 a Cart.Entry or a RequestError.
    func addToCart(_ food: Food, quantity: Int, completion: @escaping AddItemHandler)

    /// Removes an entry from the user's cart.
    /// - Parameters:
    ///   - cartEntry: The entry to remove from the user's cart.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes the result of the request which may be
    ///                 nothing or a RequestError.
    func removeFromCart(_ cartEntry: Cart.Entry, completion: @escaping RemoveItemHandler)
}
