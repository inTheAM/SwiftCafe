//
//  MockAuthService.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

@testable import SwiftCafe

final class MockAuthService: AuthServiceProtocol {
    static var token: String?
    
    func checkEmailAvailability(email: String, completion: @escaping (Bool) -> Void) {
        if email == User.sample.email {
            completion(false)
        } else {
            completion(true)
        }
    }
    
    
}
