//
//  AuthServiceProtocol.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Combine

/// #A protocol for services that handle user authentication/authorization.
protocol AuthServiceProtocol {

    /// Checks whether an email address is available for use in account creation.
    /// - Parameters:
    ///   - email: The email address to check availability for.
    /// - Returns: - A publisher that publishes the result of the request as an  `EmailCheckResult`.
    func checkEmailAvailability(email: String) -> AnyPublisher<EmailCheckResult, Never>

    /// Signs up a user using the email address and the password provided.
    /// - Parameters:
    ///   - email: The email address to sign the user up with.
    ///   - password: The password to authenticate the user with.
    /// - Returns: - A publisher that publishes the result of the request as an  `AuthResult`.
    func signUp(email: String, password: String) -> AnyPublisher<AuthResult, Never>

    /// Signs in a user using the email address and the password provided.
    /// - Parameters:
    ///   - email: The email address to sign in with.
    ///   - password: The password to unlock the account.
    /// - Returns: - A publisher that publishes the result of the request as an  `AuthResult`.
    func signIn(email: String, password: String) -> AnyPublisher<AuthResult, Never>

    func signOut() -> AnyPublisher<AuthResult, Never>
}
