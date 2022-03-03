//
//  TokenStoreStub.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 03/03/2022.
//

import Foundation
@testable import SwiftCafe

enum TokenStoreStub: TokenStoreProtocol {
    static var token: String?

    static func setTokenValue(_ token: Token?) {
        if let newToken = token {
            Self.token = newToken.value
        } else {
            Self.token = nil
        }
    }
}
