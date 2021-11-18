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
        if environment == "TEST" {
            return MockAuthService()
        } else {
            return AuthService.shared
        }
    }
}
