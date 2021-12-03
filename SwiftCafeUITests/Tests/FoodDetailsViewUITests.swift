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
        let sheet = app.sheets["Food details"]
        let foodName = sheet.staticTexts["Food 1"]
        let foodPrice = sheet.staticTexts["$12"]
        let foodDetails = sheet.staticTexts["Food details"]

        XCTAssert(sheet.exists)
        XCTAssert(foodName.exists)
        XCTAssert(foodPrice.exists)
        XCTAssert(foodDetails.exists)
    }

// MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
