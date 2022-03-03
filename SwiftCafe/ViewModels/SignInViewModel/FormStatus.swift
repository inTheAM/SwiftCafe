//
//  FormStatus.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// #The validity status of the form during sign-in.
enum FormStatus {
    case emailEmpty
    case passwordEmpty
    case valid

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
