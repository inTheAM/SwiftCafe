//
//  MenuViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

@testable import SwiftCafe
import XCTest

final class MenuViewUITests: XCTestCase {
    let app = XCUIApplication()

// MARK: - Setup
    override func setUpWithError() throws {
        app.launchInTestEnvironment()
    }

// MARK: - Tests
    func testSectionSelectorsExist() throws {
        XCTAssert(app.buttons["Section 1"].exists)
        XCTAssert(app.buttons["Section 2"].exists)
    }

    func testFoodCardsExist() throws {
        let foodCard = app.buttons["Food 1"]
        XCTAssert(foodCard.exists)
    }

    func testCartButtonExists() throws {
        let cartButton = app.buttons["Cart"]
        XCTAssert(cartButton.exists)
    }

    func testLocationButtonExists() throws {
        let locationButton = app.buttons["Location"]
        XCTAssert(locationButton.exists)
    }

// MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
