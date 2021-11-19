//
//  CartServiceFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation

struct CartServiceFactory {
    static func create() -> CartServiceProtocol {
        let environment = ProcessInfo.processInfo.environment["ENV"]

        switch environment {
        case "TEST":
            return MockCartService()
        default:
            return CartService()
        }
    }
}
