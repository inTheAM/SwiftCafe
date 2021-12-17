//
//  MockFoodDetailsService.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation
@testable import SwiftCafe

/// #A mock implementation of `FoodDetailsService`.
struct MockFoodDetailsService: FoodDetailsServiceProtocol {

    /// Mocks fetching option groups for a food item by passing sample option groups.
    /// - Parameters:
    ///   - foodID: The identifier for the food item to fetch options for.
    ///   - completion: A closure the method runs to pass the fetched option groups.
    ///                 The closure takes an array of `OptionGroup`
    func fetchOptions(for foodID: UUID, completion: @escaping (Result<[OptionGroup], RequestError>) -> Void) {
        completion(.success(OptionGroup.samples))
    }
}
