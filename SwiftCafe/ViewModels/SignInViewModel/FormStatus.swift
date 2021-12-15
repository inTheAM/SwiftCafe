//
//  FormStatus.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// #The validity status of the form during sign-in.
enum FormStatus {

    /// The email input is empty.
    case emailEmpty

    /// The password input is empty.
    case passwordEmpty

    /// Both email and password inputs are valid.
    case valid

    /// The inline error displayed depending on the form status.
    var description: String {
        switch self {
        case .emailEmpty:
            return "Input your email address"
        case .passwordEmpty:
            return "Enter your password"
        case .valid:
            return ""
        }
    }
}
