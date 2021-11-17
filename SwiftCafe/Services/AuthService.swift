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
}
