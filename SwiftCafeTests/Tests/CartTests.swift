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
    func testFetchingCartContents() throws {
        let contentsPublisher = cart.$contents
            .dropFirst()
            .first()
        cart.fetchContents()

        let contents = try awaitResult(from: contentsPublisher)
        XCTAssertEqual(contents.count, Cart.Entry.samples.count)
        XCTAssertEqual(contents[0].id, Cart.Entry.samples[0].id)
        XCTAssertEqual(contents[0].quantity, Cart.Entry.samples[0].quantity)
    }

    func testAddingFoodToCart() throws {
        let contentsPublisher = cart.$contents
            .first()
        let food = MenuSection.samples[0].items[0]
        let quantity = 3
        cart.add(food, quantity: quantity)

        let contents = try awaitResult(from: contentsPublisher)
        XCTAssertEqual(contents[0].food.id, food.id)
        XCTAssertEqual(contents[0].quantity, quantity)
    }

    func testRemovingFoodFromCart() throws {
        let contentsPublisher = cart.$contents
            .first()

        let food = MenuSection.samples[0].items[0]
        let food2 = MenuSection.samples[0].items[1]
        let quantity = 3
        cart.add(food, quantity: quantity)
        cart.add(food2, quantity: quantity)
        cart.remove(food)

        let contents = try awaitResult(from: contentsPublisher)

        XCTAssertEqual(contents.count, 1)
        XCTAssertEqual(contents[0].food.id, food2.id)
    }

    func testCheckingCartContainsFood() throws {
        let food = MenuSection.samples[0].items[0]
        let quantity = 3
        cart.add(food, quantity: quantity)
        let isInCart = cart.contains(food)
        XCTAssertTrue(isInCart)
    }

// MARK: - Teardown
    override func tearDownWithError() throws {
        cart = nil
    }
}
