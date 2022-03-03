//
//  EmailCheckResult.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/03/2022.
//

import Foundation

/// #The result of a check for the availability of an email address for account creation.
enum EmailCheckResult {
    case available

    case unavailable

    case failure

    var description: String {
        switch self {
        case .available:
            return ""
        case .unavailable:
            return "This email address is already in use."
        case .failure:
            return "There was a problem checking if this email address is registered."
        }
    }
}
