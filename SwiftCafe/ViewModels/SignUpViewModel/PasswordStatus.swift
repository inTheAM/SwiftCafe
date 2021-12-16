//
//  PasswordStatus.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// #The validity status of the password input.
enum PasswordStatus: String {

    /// The password input is empty.
    case empty

    /// The password is too short.
    case short

    /// The password is too weak; does not match the predicate.
    case weak

    /// The password inputs do not match.
    case passwordsDoNotMatch

    /// The password inputs are valid.
    case valid

    /// The inline error displayed depending on the password status
    var inlineError: String {
        switch self {
        case .empty:
            return "Password cannot be empty"
        case .short:
            return "Password is too short. Use 8 characters or more"
        case .weak:
            return "Password must contain at least one number and one special character"
        case .passwordsDoNotMatch:
            return "Passwords do not match"
        case .valid:
            return ""
        }
    }
}
