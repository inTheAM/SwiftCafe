//
//  AuthService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

protocol AuthServiceProtocol {
    static var token: String? { get set }
    func checkEmailAvailability(email: String, completion: @escaping (Bool) -> Void)
    func signUp(email: String, password: String, completion: @escaping (AuthResult) -> Void)
}

enum AuthResult {
    case success,
         failure
}

final class AuthService {
    static let shared = AuthService()
    
    private init() {}
}

extension AuthService: AuthServiceProtocol {
    static var token: String? = nil
    
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
    
    func signUp(email: String, password: String, completion: @escaping (AuthResult) -> Void) {
        let user = User.CreateData(email: email, password: password)
        
        NetWorkManager.makePostRequestWithReturn(sending: user, receiving: Token.self, path: "users/signup", authType: .none) { result in
            switch result {
            case .success(let token):
                Self.token = token.value
                completion(.success)
                
            case .failure:
                completion(.failure)
            }
        }
    }
}
