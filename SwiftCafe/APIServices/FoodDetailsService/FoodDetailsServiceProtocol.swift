//
//  FoodDetailsServiceProtocol.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// A protocol for services that handle fetching details for a selected food item.
protocol FoodDetailsServiceProtocol {

    /// A type representing a closure that takes a result containing either an array of OptionGroup or a RequestError.
    /// The closure returns nothing.
        typealias OptionsHandler = (Result<[OptionGroup], RequestError>) -> Void

    /// Fetches the options for the food item.
    /// - Parameters:
    ///   - foodID: The identifier for the food item to fetch details for.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes the result of the request which may be
    ///                 an array of OptionGroup or a RequestError.
    func fetchOptions(for foodID: UUID, completion: @escaping OptionsHandler)
}
