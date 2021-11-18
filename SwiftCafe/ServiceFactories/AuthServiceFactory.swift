//
//  AuthServiceFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import Foundation

struct AuthServiceFactory {
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
