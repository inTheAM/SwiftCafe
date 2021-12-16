//
//  MenuViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

@testable import SwiftCafe
import XCTest

/// #Tests the MenuView.
final class MenuViewUITests: XCTestCase {
    /// The test application instance.
    let app = XCUIApplication()

    // MARK: - Setup
    /// Launches the application in a test environment.
    override func setUpWithError() throws {
        app.launchInTestEnvironment()
    }

    // MARK: - Tests
    /// Tests the section selectors at the top of the view exist.
    func testSectionSelectorsExist() throws {
        XCTAssert(app.buttons["Section 1"].exists)
        XCTAssert(app.buttons["Section 2"].exists)
    }

    /// Tests the food cards exist.
    func testFoodCardsExist() throws {
        let foodCard = app.buttons["Food 1"]
        XCTAssert(foodCard.exists)
    }

    /// Tests the overlaid cart button exists.
    func testCartButtonExists() throws {
        let cartButton = app.buttons["Cart"]
        XCTAssert(cartButton.exists)
    }

    /// Tests the location button exists.
    func testLocationButtonExists() throws {
        let locationButton = app.buttons["Location"]
        XCTAssert(locationButton.exists)
    }

// MARK: - Teardown
    /// Terminates the test application instance.
    override func tearDownWithError() throws {
        app.terminate()
    }
}
