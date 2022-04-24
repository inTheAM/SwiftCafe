//
//  AuthService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
import Foundation

/// #A service that handles user authentication.
/// ##Holds the token used to perform authorization in requests.
final class AuthService {
    private let networkManager = NetworkManager()

    /// The shared singleton instance of this service.
    static let shared = AuthService()

    /// The private initializer for this service.
    private init() {}
}

extension AuthService: AuthServiceProtocol {
    
    func checkEmailAvailability(email: String) -> AnyPublisher<EmailCheckResult, Never> {
        let email = User.EmailCheckData(email: email)

        return networkManager.makeRequestPublisher(endpoint: .checkEmail, payload: email)
            .map { result -> EmailCheckResult in
                switch result.isAvailable {
                case true:
                    return .available
                case false:
                    return .unavailable
                }
            }
            .catch { _ -> AnyPublisher<EmailCheckResult, Never> in
                return Just(.failure)
                    .setFailureType(to: Never.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func signUp(email: String, password: String) -> AnyPublisher<AuthResult, Never> {
        let user = User.SignInData(email: email, password: password)

        return networkManager
            .makeRequestPublisher(endpoint: .signUp, payload: user)
            .map { token -> AuthResult in
                TokenStore.setTokenValue(token)
                return .success
            }
            .catch { _ -> AnyPublisher<AuthResult, Never> in
                return Just(.signUpFailed)
                    .setFailureType(to: Never.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func signIn(email: String, password: String) -> AnyPublisher<AuthResult, Never> {
        let authData = "\(email):\(password)".data(using: .utf8)!.base64EncodedString()

        return networkManager
            .makeRequestPublisher(endpoint: .signIn(authData), payload: nil)
            .map { token in
                TokenStore.setTokenValue(token)
                return .success
            }

            .catch { _ -> AnyPublisher<AuthResult, Never> in
                return Just(.signInFailed)
                    .setFailureType(to: Never.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher<AuthResult, Never> {
        return networkManager.makeRequestPublisher(endpoint: .signOut)
            
            .map { _ in
                AuthResult.success
            }
            .catch { _ -> AnyPublisher<AuthResult, Never> in
                return Just(.signOutFailed)
                    .setFailureType(to: Never.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
