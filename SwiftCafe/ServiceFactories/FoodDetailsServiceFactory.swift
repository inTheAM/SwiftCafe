//
//  FoodDetailsServiceFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation

/// A factory that returns a type conforming to the FoodDetailsServiceProtocol
struct FoodDetailsServiceFactory {
    
    /// Creates a type that conforms to the FoodDetailsServiceProtocol depending on environment value for "ENV".
    /// - Returns: Either a FoodDetailsService instance or
    ///            a MockFoodDetailsService instance if the app is launched in testing.
    static func create() -> FoodDetailsServiceProtocol {
        let environment = ProcessInfo.processInfo.environment["ENV"]

        switch environment {
        case "TEST":
            return MockFoodDetailsService()
        default:
            return FoodDetailsService()
        }
    }
}
