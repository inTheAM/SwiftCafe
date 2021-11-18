//
//  MockAuthService.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

@testable import SwiftCafe

final class MockAuthService: AuthServiceProtocol {
    var token: String?
    
    func checkEmailAvailability(email: String, completion: @escaping (Bool) -> Void) {
        if email == User.sample.email {
            completion(false)
        } else {
            completion(true)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (AuthResult) -> Void) {
        if email != User.sample.email && !email.hasPrefix("fail") {
            completion(.success)
            token = "token"
        } else {
            completion(.failure)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (AuthResult) -> Void) {
        if email == User.sample.email && password == User.sample.password {
            completion(.success)
            token = "token"
        } else {
            completion(.failure)
        }
    }
}
