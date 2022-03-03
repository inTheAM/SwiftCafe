//
//  CartServiceProtocol.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Combine
import Foundation

/// #A protocol for services that manage requests that involve cart operations.
protocol CartServiceProtocol {

    /// Fetches the contents of the user's cart.
    func fetchContents() -> AnyPublisher<[Cart.Entry], CartError>

    /// Adds an item to the user's cart.
    /// - Parameters:
    ///   - food: The item to add to the user's cart.
    ///   - quantity: The quantity of the item to add to the user's cart.
    /// - Returns: A Publisher that publishes either a Cart.Entry if the request was
    ///            successful or a CartError if the request failed.
    func addToCart(_ food: Food, quantity: Int) -> AnyPublisher<Cart.Entry?, CartError>

    /// Removes an entry from the user's cart.
    /// - Parameters:
    ///   - cartEntry: The entry to remove from the user's cart.
    /// - Returns: A Publisher that publishes either the UUID of the deleted item if the request was
    ///            successful or a CartError if the request failed.
    func removeFromCart(_ cartEntry: Cart.Entry) -> AnyPublisher<UUID?, CartError>
}
