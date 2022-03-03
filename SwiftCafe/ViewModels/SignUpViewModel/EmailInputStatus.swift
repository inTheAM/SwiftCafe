//
//  EmailStatus.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// #The validity status of the email input.
enum EmailInputStatus: String {
    case empty
    case invalid
    case valid

    var description: String {
        switch self {
        case .empty:
            return "Email cannot be empty"
        case .invalid:
            return "Use a valid email address"
        case .valid:
            return ""
        }
    }
}
