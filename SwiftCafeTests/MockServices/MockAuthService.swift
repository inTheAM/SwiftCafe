//
//  MockAuthService.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
@testable import SwiftCafe
import UIKit

/// #A mock implementation of `AuthService`.
final class MockAuthService: AuthServiceProtocol {
    func signOut() -> AnyPublisher<AuthResult, Never> {
        Just(.success)
            .eraseToAnyPublisher()
    }

    /// The shared singleton instance of the mock service.
    static let shared = MockAuthService()

    /// The private initializer for the mock service.
    private init() {}

    /// Compares an email address to the sample user's email address to mock
    /// a check for email address availability.
    /// - Parameters:
    ///   - email: The email address to check.
    ///   - completion: A closure the method runs after the comparison is complete.
    ///                 The closure takes a boolean value that indicates whether the email address is available or not.
    func checkEmailAvailability(email: String) -> AnyPublisher<EmailCheckResult, Never> {
        if email != User.sample.email {
            print("EMAIL AVAILABLE")
            return Just(.available)
                .setFailureType(to: Never.self)
                .eraseToAnyPublisher()
        } else {
            print("EMAIL UNAVAILABLE")
            return Just(.unavailable)
                .setFailureType(to: Never.self)
                .eraseToAnyPublisher()
        }
    }

    /// Mocks sign-up by ensuring the test user does not match the existing sample user.
    /// Sets the token if the sign-up succeeds.
    /// - Parameters:
    ///   - email: The email address to test sign-up with.
    ///   - password: The password to test sign-up with.
    ///   - completion: A closure the method runs after the sign-up is complete.
    ///                 The closure takes an `AuthResult` that indicates whether the sign-up was successful or not.
    func signUp(email: String, password: String) -> AnyPublisher<AuthResult, Never> {
        if email != User.sample.email && !email.hasPrefix("fail") {
            print("ADDING USER MOCK")
            TokenStoreStub.token = "token"
            return Just(.success)
                .setFailureType(to: Never.self)
                .eraseToAnyPublisher()
        } else {
            print("FAILED SIGNUP IN MOCK")
            return Just(.signUpFailed)
                .setFailureType(to: Never.self)
                .eraseToAnyPublisher()
        }
    }

    /// Mocks sign-in by ensuring the test user matches the existing sample user.
    /// - Parameters:
    ///   - email: The email address to test sign-in with.
    ///   - password: The password to test sign-in with.
    ///   - completion: A closure the method runs after the sign-in is complete.
    ///                 The closure takes an `AuthResult` that indicates whether the sign-in was successful or not.
    func signIn(email: String, password: String) -> AnyPublisher<AuthResult, Never> {
        if email == User.sample.email && password == User.sample.password {
            TokenStoreStub.token = "token"
            return Just(.success)
                .setFailureType(to: Never.self)
                .eraseToAnyPublisher()

        } else {
            return Just(.invalidUsernameOrPassword)
                .setFailureType(to: Never.self)
                .eraseToAnyPublisher()
        }
    }
}
