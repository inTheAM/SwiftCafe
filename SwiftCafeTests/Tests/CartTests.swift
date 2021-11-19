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

// MARK: - Tests
    func testAddingItemToCart() throws {
        let contentsPublisher = cart.$contents
            .first()
        let food = MenuSection.samples[0].items[0]
        let quantity = 3
        cart.addToCart(food, quantity: quantity)

        let contents = try awaitResult(from: contentsPublisher)
        XCTAssertEqual(contents[0].food.id, food.id)
        XCTAssertEqual(contents[0].quantity, quantity)
    }

// MARK: - Teardown
    override func tearDownWithError() throws {
        cart = nil
    }
}
