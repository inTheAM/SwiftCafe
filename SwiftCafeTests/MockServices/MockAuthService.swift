//
//  MockAuthService.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

@testable import SwiftCafe
import UIKit

/// #A mock implementation of `AuthService`.
final class MockAuthService: AuthServiceProtocol {
    /// The shared singleton instance of the mock service.
    static let shared = MockAuthService()

    /// The private initializer for the mock service.
    private init() {}

    /// The token value used to switch between
    /// testing sign-up/sign-in and the rest of the app.
    /// A value for the token means that the user is signed in and the app
    /// launches to the MenuView.
    /// If the token is nil then the user's session expired and the app launches to the SignInView and
    /// sign-up/sign-in testing can proceed.
    var token: String?

    /// Compares an email address to the sample user's email address to mock
    /// a check for email address availability.
    /// - Parameters:
    ///   - email: The email address to check.
    ///   - completion: A closure the method runs after the comparison is complete.
    ///                 The closure takes a boolean value that indicates whether the email address is available or not.
    func checkEmailAvailability(email: String, completion: @escaping AvailabilityHandler) {
        if email == User.sample.email {
            completion(false)
        } else {
            completion(true)
        }
    }

    /// Mocks sign-up by ensuring the test user does not match the existing sample user.
    /// Sets the token if the sign-up succeeds.
    /// - Parameters:
    ///   - email: The email address to test sign-up with.
    ///   - password: The password to test sign-up with.
    ///   - completion: A closure the method runs after the sign-up is complete.
    ///                 The closure takes an `AuthResult` that indicates whether the sign-up was successful or not.
    func signUp(email: String, password: String, completion: @escaping AuthResultHandler) {
        if email != User.sample.email && !email.hasPrefix("fail") {
            completion(.success)
            token = "token"
        } else {
            completion(.failure)
        }
    }

    /// Mocks sign-in by ensuring the test user matches the existing sample user.
    /// - Parameters:
    ///   - email: The email address to test sign-in with.
    ///   - password: The password to test sign-in with.
    ///   - completion: A closure the method runs after the sign-in is complete.
    ///                 The closure takes an `AuthResult` that indicates whether the sign-in was successful or not.
    func signIn(email: String, password: String, completion: @escaping AuthResultHandler) {
        if email == User.sample.email && password == User.sample.password {
            completion(.success)
            token = "token"
        } else {
            completion(.failure)
        }
    }
}
