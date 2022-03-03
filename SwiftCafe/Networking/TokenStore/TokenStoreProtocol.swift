//
//  TokenStoreProtocol.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/03/2022.
//

import Foundation

protocol TokenStoreProtocol {
    static var token: String? { get }
    static func setTokenValue(_ token: Token?)
}
