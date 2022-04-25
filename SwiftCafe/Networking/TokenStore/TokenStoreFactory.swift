//
//  TokenStoreFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/03/2022.
//

import Foundation

/// #A factory that returns a type conforming to the TokenStoreProtocol.
enum TokenStoreFactory {

    /// Creates a type that conforms to the MenuServiceProtocol depending on environment value for "ENV".
    /// - Returns: Either a MenuService instance or
    ///            a MockMenuService instance if the app is launched in testing.
    static func create() -> TokenStoreProtocol.Type {
        let environment = ProcessInfo.processInfo.environment["ENV"]

        switch environment {
            case "TEST_SIGNUP":
                return TokenStoreStub.self
            case "TEST":
                TokenStoreStub.token = "token"
                return TokenStoreStub.self
            default:
                return TokenStore.self
        }
    }
}
