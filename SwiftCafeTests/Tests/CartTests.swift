//
//  CartTests.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

@testable import SwiftCafe
import XCTest

final class CartTests: XCTestCase {
    private var cart: Cart!

// MARK: - Setup
    override func setUpWithError() throws {
        let cartService = MockCartService()
        cart = Cart(cartService: cartService)
    }
}
