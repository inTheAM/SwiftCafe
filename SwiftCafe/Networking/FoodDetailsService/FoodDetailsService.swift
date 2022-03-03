//
//  FoodDetailsService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Combine
import Foundation

/// #A service that handles fetching details of a selected item.
struct FoodDetailsService: FoodDetailsServiceProtocol {
    private let networkManager: NetworkManager = NetworkManager()
    /// Makes a network request to fetch the options for the selected food item.
    /// - Parameters:
    ///   - foodID: The identifier for the food item to fetch details for.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes the result of the request which may be
    ///                 an array of OptionGroup or a RequestError.
    func fetchOptions(for foodID: UUID) -> AnyPublisher<[OptionGroup], RequestError> {
        networkManager.makeRequestPublisher(.get, endpoint: Endpoint.fetchItemOptions(foodID))
            .eraseToAnyPublisher()
    }
}
