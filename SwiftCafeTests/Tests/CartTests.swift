//
//  CartTests.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

@testable import SwiftCafe
import XCTest

/// #Tests the Cart.
final class CartTests: XCTestCase {
    /// The cart instance under test.
    private var cart: Cart!
    private let testFood = MenuSection.samples[0].items[0]
    private let testFood2 = MenuSection.samples[0].items[1]

    // MARK: - Setup
    /// Sets up the test cart with a mock cart service.
    override func setUpWithError() throws {
        let cartService = MockCartService()
        cart = Cart(cartService: cartService)
    }

    // MARK: - Tests
    /// Tests fetching the cart contents.
    func test1_FetchingCartContents() throws {
        let contentsPublisher = cart.$contents
            .dropFirst()
            .first()

        cart.fetchContents()

        let contents = try awaitResult(from: contentsPublisher)
        XCTAssertEqual(contents.count, Cart.Entry.samples.count)
        XCTAssertEqual(contents[0].id, Cart.Entry.samples[0].id)
        XCTAssertEqual(contents[0].quantity, Cart.Entry.samples[0].quantity)
    }

    /// Tests adding an item to the cart.
    func test2_AddingFoodToCart() throws {
        let contentsPublisher = cart.$contents
            .dropFirst()
            .collect(2)
            .first()

        cart.add(testFood, quantity: 3)
        cart.add(testFood2, quantity: 2)

        let contentsResult = try awaitResult(from: contentsPublisher)
        XCTAssertEqual(contentsResult.count, 2)

        let firstAddContents = contentsResult[0]
        XCTAssertEqual(firstAddContents.count, 1)
        let secondAddContents = contentsResult[1]
        XCTAssertEqual(secondAddContents.count, 2)
        XCTAssertEqual(firstAddContents[0].food.id, testFood.id)
        XCTAssertEqual(firstAddContents[0].quantity, 3)
        XCTAssertEqual(secondAddContents[1].food.id, testFood2.id)
        XCTAssertEqual(secondAddContents[1].quantity, 2)
    }

    /// Tests removing an item from the cart.
    func test3_RemovingFoodFromCart() throws {
        let contentsPublisher = cart.$contents
            .dropFirst()
            .collect(2)
            .first()

        cart.add(testFood, quantity: 3)
        cart.add(testFood2, quantity: 2)
        _ = try awaitResult(from: contentsPublisher)

        let postRemovalPublisher = cart.$contents
            .dropFirst()
            .first()

        cart.remove(testFood)

        let postRemovalContents = try awaitResult(from: postRemovalPublisher)

        XCTAssertEqual(postRemovalContents.count, 1)
        XCTAssertEqual(postRemovalContents[0].food.id, testFood2.id)
    }

    // MARK: - Teardown
    /// Tears down the test cart.
    override func tearDownWithError() throws {
        cart = nil
    }
}
