//
//  EmailStatus.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// The validity status of the email input.
enum EmailStatus: String {

    /// The email input is empty.
    case empty

    /// The email input failed validation.
    case invalid

    /// The email address is unavailable for account creation.
    case unavailable

    /// The email input is valid.
    case valid

    /// The inline error displayed depending on the email input status.
    var inlineError: String {
        switch self {
        case .empty:
            return "Email cannot be empty"
        case .invalid:
            return "Use a valid email address"
        case .unavailable:
            return "This email address is already in use."
        case .valid:
            return ""
        }
    }
}
