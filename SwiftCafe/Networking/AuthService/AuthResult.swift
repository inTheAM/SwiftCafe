//
//  AuthResult.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// #The result of an authentication request
enum AuthResult {
    case success
    case invalidUsernameOrPassword
    case signUpFailed
    case signInFailed
    case signOutFailed

    var description: String {
        switch self {
        case .signUpFailed:
            return "There was a problem creating your account."
        case .invalidUsernameOrPassword:
            return "Your email or password is incorrect"
        case .signOutFailed:
            return "There was a problem signing out."
        case .signInFailed:
            return "There was a problem signing in."
        case .success:
            return ""
        }
    }
}

extension AuthResult: Codable {

}
