//
//  AccessLevelProtocol.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 01/03/2022.
//

import Foundation

/// #A protocol for access levels for endpoints.
protocol AccessLevelProtocol { }

enum PublicAccess: AccessLevelProtocol { }

enum PrivateAccess: AccessLevelProtocol { }

enum SignInAccess: AccessLevelProtocol { }

enum SignUpAccess: AccessLevelProtocol { }

enum AccessLevel {
    case basic(_ authData: String)
    case token
    case publicAccess
}
