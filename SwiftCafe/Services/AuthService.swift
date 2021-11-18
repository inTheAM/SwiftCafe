//
//  AuthService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

protocol AuthServiceProtocol {
    var token: String? { get set }
    func checkEmailAvailability(email: String, completion: @escaping (Bool) -> Void)
    func signUp(email: String, password: String, completion: @escaping (AuthResult) -> Void)
    func signIn(email: String, password: String, completion: @escaping (AuthResult) -> Void)
}

enum AuthResult {
    case success,
         failure
}

final class AuthService {
    private let path = "users"
    static let shared = AuthService()
    var token: String? = nil
    private init() {}
}

extension AuthService: AuthServiceProtocol {
    
//    MARK: - Email Availability
    func checkEmailAvailability(email: String, completion: @escaping (Bool) -> Void) {
        let validationData = User.ValidateData(email: email)
        NetWorkManager.makePostRequestWithoutReturn(sending: validationData, path: "users/validate", authType: .none) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
//    MARK: - Sign Up
    func signUp(email: String, password: String, completion: @escaping (AuthResult) -> Void) {
        let user = User.CreateData(email: email, password: password)
        
        NetWorkManager.makePostRequestWithReturn(sending: user, receiving: Token.self, path: "users/signup", authType: .none) { result in
            switch result {
            case .success(let token):
                self.token = token.value
                completion(.success)
                
            case .failure:
                completion(.failure)
            }
        }
    }
    
//    MARK: - Sign In
    func signIn(email: String, password: String, completion: @escaping (AuthResult) -> Void) {
        guard let loginString = "\(email):\(password)".data(using: .utf8)?.base64EncodedString() else {
            completion(.failure)
            return
        }
        
        NetWorkManager.makePostRequestWithReturn(sending: "", receiving: Token.self, path: path + "/signin", authType: .basic(value: loginString)) { result in
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
