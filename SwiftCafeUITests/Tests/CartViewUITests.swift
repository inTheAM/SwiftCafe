//
//  CartViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 19/11/2021.
//

@testable import SwiftCafe
import XCTest

final class CartViewUITests: XCTestCase {
    let app = XCUIApplication()

// MARK: - Setup
    override func setUpWithError() throws {
        app.launchWithTestEnvironment()
        let cartButton = app.buttons["Cart"]
        cartButton.tap()
    }

// MARK: - Tests
    func testNavigationTitleExists() throws {
        let navTitle = app.navigationBars.staticTexts["Your bag"]
        XCTAssert(navTitle.exists)
    }

    func testDoneButtonExists() throws {
        let doneButton = app.buttons["Done"]
        XCTAssert(doneButton.exists)
    }

    func testDoneButtonDismissesCartView() throws {
        let doneButton = app.buttons["Done"]
        doneButton.tap()
        XCTAssertFalse(doneButton.exists)
    }

// MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
