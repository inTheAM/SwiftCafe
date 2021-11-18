//
//  MenuServiceFactory.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import Foundation

struct MenuServiceFactory {
    static func create() -> MenuServiceProtocol {
        let environment = ProcessInfo.processInfo.environment["ENV"]

        switch environment {
        case "TEST":
            return MockMenuService()
        default:
            return MenuService()
        }
    }
}
