//
//  AuthService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #A service that handles user authentication.
/// ##Holds the token used to perform authorization in requests.
final class AuthService {

    /// The keychain identifier for token storage.
    private let keychainKey = "SWIFTCAFE-API-KEY"

    /// The token used to authorize requests.
    /// A present value for the token means that the user is signed in.
    /// A value of nil for the token indicates that the user's session expired.
    var token: String? {
        get {
          Keychain.load(key: keychainKey)
        }
        set {
          if let newToken = newValue {
            Keychain.save(key: keychainKey, data: newToken)
          } else {
            Keychain.delete(key: keychainKey)
          }
        }
    }

    /// The shared singleton instance of this service.
    static let shared = AuthService()

    /// The private initializer for this service.
    private init() {}
}

extension AuthService: AuthServiceProtocol {

    /// Makes a network request to check whether an email address is available for use in account creation.
    /// - Parameters:
    ///   - email: The email address to check availability for.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes a boolean value that indicates whether the email address is available or not.
    func checkEmailAvailability(email: String, completion: @escaping AvailabilityHandler) {
        let validationData = User.ValidateData(email: email)

        NetWorkManager.makePostRequestWithoutReturn(
            sending: validationData,
            path: "users/validate",
            authType: .none
        ) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }

    /// Makes a network request to sign up a user using the email address and the password provided.
    /// - Parameters:
    ///   - email: The email address to sign the user up with.
    ///   - password: The password to authenticate the user with.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes an AuthResult value that indicates whether the sign-up was successful or not.
    func signUp(email: String, password: String, completion: @escaping AuthResultHandler) {
        let user = User.CreateData(email: email, password: password)

        NetWorkManager.makePostRequestWithReturn(
            sending: user,
            receiving: Token.self,
            path: "users/signup",
            authType: .none
        ) { result in
            switch result {
            case .success(let token):
                self.token = token.value
                completion(.success)

            case .failure:
                completion(.failure)
            }
        }
    }

    /// Makes a network request to sign in a user using the email address and the password provided
    /// - Parameters:
    ///   - email: The email address to sign the user in with.
    ///   - password: The password to authenticate the user with.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes an AuthResult value that indicates whether the sign-in was successful or not.
    func signIn(email: String, password: String, completion: @escaping AuthResultHandler) {
        guard let loginString = "\(email):\(password)".data(using: .utf8)?.base64EncodedString() else {
            completion(.failure)
            return
        }

        NetWorkManager.makePostRequestWithReturn(
            sending: "",
            receiving: Token.self,
            path: "users/signin",
            authType: .basic(value: loginString)
        ) { result in
            switch result {
            case .success(let token):
                self.token = token.value
                completion(.success)

            case .failure:
                completion(.failure)
            }
        }
    }
}
