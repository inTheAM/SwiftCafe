//
//  AuthServiceFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import Foundation

/// #A factory that creates a type that conforms to the AuthServiceProtocol.
struct AuthServiceFactory {

    /// Creates a type that conforms to the AuthServiceProtocol depending on environment value for "ENV".
    /// - Returns: Either the shared AuthService instance or
    ///            a MockAuthService instance if the app is launched in testing.
    ///            If the testing is in the sign-up/sign-in phase, no token is attached,
    ///            otherwise a test token is added to the mock service.
    static func create() -> AuthServiceProtocol {
        let environment = ProcessInfo.processInfo.environment["ENV"]

        switch environment {
        case "TEST_SIGNUP":
            return MockAuthService()
        case "TEST":
            let mockAuthService = MockAuthService()
            mockAuthService.token = "token"
            return mockAuthService
        default:
            return AuthService.shared
        }
    }
}
