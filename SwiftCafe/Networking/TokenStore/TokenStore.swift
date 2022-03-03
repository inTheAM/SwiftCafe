//
//  TokenStore.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/03/2022.
//

import Foundation

enum TokenStore: TokenStoreProtocol {
    private static let keychainKey: String = "SWIFTCAFE-TOKEN-KEY"

    static var token: String? {
        Keychain.load(key: keychainKey)
    }

    static func setTokenValue(_ token: Token?) {
        if let newToken = token {
            Keychain.save(key: keychainKey, data: newToken.value)
        } else {
          Keychain.delete(key: keychainKey)
        }
    }
}
