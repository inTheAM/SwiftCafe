//
//  User.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #The User data.
struct User: Codable {

    /// The permanent identifier for this user.
    let id: UUID

    /// The email address associated with this user's account.
    let email: String
}

extension User {

    /// #The data used to create a new user.
    struct SignInData: Encodable {

        /// The email address to create an account with.
        let email: String

        /// The password to create an account with.
        let password: String
    }

    struct SignUpData: Encodable {
        let firstName: String
        let lastName: String
        let email: String
        let password: String
    }
}

extension User {

    /// #The data used to check for email address availability
    /// #for account creation.
    struct EmailCheckData: Encodable {

        /// The email address to check availability for.
        let email: String
    }

    struct EmailCheckResult: Decodable {
        let isAvailable: Bool
    }
}
