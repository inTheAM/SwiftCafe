//
//  User+Sample.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

@testable import SwiftCafe

extension User {
    /// A sample user.
    static let sample = User.CreateData(email: "testuser@test.com", password: "password@123")
}
