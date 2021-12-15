//
//  FoodDetailsService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation

/// #A service that handles fetching details of a selected item.
struct FoodDetailsService: FoodDetailsServiceProtocol {

    /// Makes a network request to fetch the options for the selected food item.
    /// - Parameters:
    ///   - foodID: The identifier for the food item to fetch details for.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes the result of the request which may be
    ///                 an array of OptionGroup or a RequestError.
    func fetchOptions(for foodID: UUID, completion: @escaping OptionsHandler) {
        NetWorkManager.makeGetRequest([OptionGroup].self,
                                      path: "options/\(foodID.uuidString)",
                                      authType: .none) { result in
            switch result {
            case .success(let sections):
                completion(.success(sections))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
