//
//  CartViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 19/11/2021.
//

@testable import SwiftCafe
import XCTest

/// #Tests the CartView.
final class CartViewUITests: XCTestCase {
    /// The test application instance.
    let app = XCUIApplication()

    // MARK: - Setup
    /// Launches the application in a test environment and
    /// taps the cart button to display the cart view.
    override func setUpWithError() throws {
        app.launchInTestEnvironment()
        let cartButton = app.buttons["Cart"]
        cartButton.tap()
    }

    // MARK: - Tests
    /// Tests the navigation title exists.
    func testNavigationTitleExists() throws {
        let navTitle = app.navigationBars.staticTexts["Your bag"]
        XCTAssert(navTitle.exists)
    }

    /// Tests the `Done` button exists
    func testDoneButtonExists() throws {
        let doneButton = app.buttons["Done"]
        XCTAssert(doneButton.exists)
    }

    /// Tests the `Done` button dismisses the cart view.
    func testDoneButtonDismissesCartView() throws {
        let doneButton = app.buttons["Done"]
        doneButton.tap()
        XCTAssertFalse(doneButton.exists)
    }

    // MARK: - Teardown
    /// Terminates the test application instance.
    override func tearDownWithError() throws {
        app.terminate()
    }
}
