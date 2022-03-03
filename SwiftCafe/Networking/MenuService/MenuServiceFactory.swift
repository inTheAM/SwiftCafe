//
//  MenuServiceFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import Foundation

/// #A factory that returns a type conforming to the MenuServiceProtocol.
enum MenuServiceFactory {

    /// Creates a type that conforms to the MenuServiceProtocol depending on environment value for "ENV".
    /// - Returns: Either a MenuService instance or
    ///            a MockMenuService instance if the app is launched in testing.
    static func create() -> MenuServiceProtocol {
        let environment = ProcessInfo.processInfo.environment["ENV"]

        switch environment {
        case "TEST":
            return MockMenuService()
        default:
            return MenuService()
        }
    }
}
