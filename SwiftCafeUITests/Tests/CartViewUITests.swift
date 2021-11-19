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
// MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
