//
//  AuthServiceFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import Foundation

/// #A factory that creates a type that conforms to the AuthServiceProtocol.
enum AuthServiceFactory {

    /// Creates a type that conforms to the AuthServiceProtocol depending on environment value for "ENV".
    /// - Returns: Either the shared AuthService instance or
    ///            a MockAuthService instance if the app is launched in testing.
    static func create() -> AuthServiceProtocol {
        let environment = ProcessInfo.processInfo.environment["ENV"]

        switch environment {
        case "TEST":
            return MockAuthService.shared
        default:
            return AuthService.shared
        }
    }
}
