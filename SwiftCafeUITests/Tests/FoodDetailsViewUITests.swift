//
//  FoodDetailsViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

@testable import SwiftCafe
import XCTest

/// #Tests the FoodDetailsView.
final class FoodDetailsViewUITests: XCTestCase {
    /// The test application instance.
    let app = XCUIApplication()

    // MARK: - Setup
    /// Launches the application in a test environment and
    /// taps a food card to show the detail view.
    override func setUpWithError() throws {
        app.launchInTestEnvironment()
        let foodCard = app.buttons["Food 2"].firstMatch
        foodCard.tap()
    }

    // MARK: - Tests
    /// Tests the food details header exists.
    /// The header shows the image, name, price
    func testFoodDetailsHeaderExist() throws {
        let foodImage = app.images["Food 2 photo"]
        let foodName = app.staticTexts["Food 2 name header"]
        let foodPrice = app.staticTexts["Total price"]
        let foodDetails = app.staticTexts["Food details details header"]
        let closeButton = app.buttons["Close"]

        XCTAssert(foodImage.waitForExistence(timeout: 10))
        XCTAssert(foodName.waitForExistence(timeout: 10))
        XCTAssert(foodPrice.waitForExistence(timeout: 10))
        XCTAssert(foodDetails.waitForExistence(timeout: 10))
        XCTAssert(closeButton.waitForExistence(timeout: 10))
    }

    /// Tests the option groups disclosure view exists and
    /// the option groups exist when the disclosure view is expanded.
    func testOptionGroupsExist() throws {
        let showOptions = app.buttons["Expand button"]
        showOptions.tap()

        let optionGroupLabel = app.staticTexts["Option group 1"]
        let option1 = app.buttons["Option group 1 Option 1"]

        XCTAssert(optionGroupLabel.waitForExistence(timeout: 10))
        XCTAssert(option1.waitForExistence(timeout: 10))
    }

    /// Tests the `Add to cart` button exists.
    func testAddToCartButtonExists() throws {
        let addToCart = app.buttons["Add to cart"]
        XCTAssert(addToCart.waitForExistence(timeout: 10))
        XCTAssertEqual(addToCart.label, "Add to cart")
    }

    /// Tests the label of the `Add to cart` button changes to
    /// `Remove from cart` when an item is added to the cart.
    func testAddToBagButtonChangesToRemoveWhenItemIsAdded() throws {
        let addToCart = app.buttons["Add to cart"]
        addToCart.tap()
        XCTAssertEqual(addToCart.label, "Remove from cart")
    }

    /// Tests the quantity stepper exists and
    /// correctly updates the quantity label.
    func testQuantityStepperExistsAndUpdates() throws {
        let stepper = app.steppers["Quantity stepper"]
        let quantity = app.staticTexts["Quantity"]
        XCTAssert(stepper.waitForExistence(timeout: 10))
        stepper.tap()
        XCTAssertEqual(quantity.label, "2")
    }

    // MARK: - Teardown
    /// Terminates the test application instance.
    override func tearDownWithError() throws {
        app.terminate()
    }
}
