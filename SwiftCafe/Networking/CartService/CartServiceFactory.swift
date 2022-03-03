//
//  CartServiceFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation

/// #A factory that returns a type conforming to the CartServiceProtocol.
enum CartServiceFactory {

    /// Creates a type that conforms to the CartServiceProtocol depending on environment value for "ENV".
    /// - Returns: Either a CartService instance or
    ///            a MockCartService instance if the app is launched in testing.
    static func create() -> CartServiceProtocol {
        let environment = ProcessInfo.processInfo.environment["ENV"]

        switch environment {
        case "TEST":
            return MockCartService()
        default:
            return CartService()
        }
    }
}
