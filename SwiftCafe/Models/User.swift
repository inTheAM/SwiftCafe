//
//  User.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

struct User: Codable {
    var id: UUID
    var email: String
}

extension User {
    struct CreateData: Codable {
        var email: String
        var password: String
    }
}

extension User {
    struct ValidateData: Codable {
        var email: String
    }
}
