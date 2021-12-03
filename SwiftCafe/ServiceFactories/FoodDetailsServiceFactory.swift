//
//  FoodDetailsServiceFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation

struct FoodDetailsServiceFactory {
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
