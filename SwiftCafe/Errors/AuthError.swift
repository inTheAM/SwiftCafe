//
//  AuthError.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// The error received in case of an authentication failure.
enum AuthError: Error {

    case signUpFailed
    case signInFailed
    case signOutFailed

    var description: String {
        switch self {
        case .signUpFailed:
            return "There was a problem creating your account."
        case .signInFailed:
            return "Your email or password is incorrect"
        case .signOutFailed:
            return "There was a problem signing out."
        }
    }
}
