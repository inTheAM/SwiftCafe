//
//  MockFoodDetailsService.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Combine
import Foundation
@testable import SwiftCafe

/// #A mock implementation of `FoodDetailsService`.
struct MockFoodDetailsService: FoodDetailsServiceProtocol {

    /// Mocks fetching option groups for a food item by passing sample option groups.
    /// - Parameters:
    ///   - foodID: The identifier for the food item to fetch options for.
    ///   - completion: A closure the method runs to pass the fetched option groups.
    ///                 The closure takes an array of `OptionGroup`
    func fetchOptions(for foodID: UUID) -> AnyPublisher<[OptionGroup], RequestError> {
        Just(OptionGroup.samples)
            .setFailureType(to: RequestError.self)
            .eraseToAnyPublisher()
    }
}
