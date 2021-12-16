//
//  AuthError.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #The error received in case of an authentication failure.
enum AuthError: Error {

    /// An error during signing up.
    case signUpFailed

    /// An error during signing in.
    case signInFailed

    /// An error during signing out.
    case signOutFailed

    /// The description of the error.
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
