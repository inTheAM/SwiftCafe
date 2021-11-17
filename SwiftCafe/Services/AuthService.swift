//
//  AuthService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

protocol AuthServiceProtocol {
    
}

final class AuthService {
    static let shared = AuthService()
    
    private init() {}
}

extension AuthService: AuthServiceProtocol {
    
}
