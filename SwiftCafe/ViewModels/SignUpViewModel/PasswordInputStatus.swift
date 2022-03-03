//
//  PasswordStatus.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// #The validity status of the password input.
enum PasswordInputStatus: String {
    case empty
    case short
    case weak
    case passwordsDoNotMatch
    case valid

    var description: String {
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
