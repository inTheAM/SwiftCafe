//
//  AuthServiceProtocol.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// #A protocol for services that handle user authentication/authorization.
protocol AuthServiceProtocol {

    /// A type representing a closure that accepts a Boolean value and returns nothing.
    typealias AvailabilityHandler = (_ isAvailable: Bool) -> Void

    /// A token used in request authorization
    var token: String? { get set }

    /// Checks whether an email address is available for use in account creation.
    /// - Parameters:
    ///   - email: The email address to check availability for.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes a boolean value that indicates whether the email address is available or not.
    func checkEmailAvailability(email: String, completion: @escaping AvailabilityHandler)

    /// A type representing a closure that accepts an authentication result and returns nothing.
    typealias AuthResultHandler = (AuthResult) -> Void

    /// Signs up a user using the email address and the password provided
    /// - Parameters:
    ///   - email: The email address to sign the user up with.
    ///   - password: The password to authenticate the user with.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes an AuthResult value that indicates whether the sign-up was successful or not.
    func signUp(email: String, password: String, completion: @escaping AuthResultHandler)

    /// Sends a sign-in request to the server.
    /// - Parameters:
    ///   - email: The email address to sign in with.
    ///   - password: The password to unlock the account.
    ///   - completion: A closure the method calls after a result from the sign-in request is received.
    ///                 The closure takes an AuthResult value that indicates whether the sign-in was successful or not.
    func signIn(email: String, password: String, completion: @escaping AuthResultHandler)
}
