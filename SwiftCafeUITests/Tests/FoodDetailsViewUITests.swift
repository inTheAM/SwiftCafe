//
//  FoodDetailsViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

@testable import SwiftCafe
import XCTest

final class FoodDetailsViewUITests: XCTestCase {
    let app = XCUIApplication()

// MARK: - Setup
    override func setUpWithError() throws {
        app.launchInTestEnvironment()
        let foodCard = app.buttons["Food 1"].firstMatch
        foodCard.tap()
    }

// MARK: - Tests
    func testFoodDetailsExist() throws {

        let foodImage = app.images["Food 1 photo"]
        let foodName = app.staticTexts["Food 1 name header"]
        let foodPrice = app.staticTexts["Total price"]
        let foodDetails = app.staticTexts["Food details details header"]
        let closeButton = app.buttons["Close"]
        let quantityStepper = app.steppers["Quantity stepper"]
        let addToCartButton = app.buttons["Add to cart"]

        XCTAssert(foodImage.waitForExistence(timeout: 10))
        XCTAssert(foodName.waitForExistence(timeout: 10))
        XCTAssert(foodPrice.waitForExistence(timeout: 10))
        XCTAssert(foodDetails.waitForExistence(timeout: 10))
        XCTAssert(closeButton.waitForExistence(timeout: 10))
        XCTAssert(quantityStepper.waitForExistence(timeout: 10))
        XCTAssert(addToCartButton.waitForExistence(timeout: 10))
    }

    func testOptionGroupsExist() throws {
        let optionGroupLabel = app.staticTexts["Option group 1"]
        let option1 = app.buttons["Option group 1 Option 1"]

        XCTAssert(optionGroupLabel.waitForExistence(timeout: 10))
        XCTAssert(option1.waitForExistence(timeout: 10))
    }

// MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
