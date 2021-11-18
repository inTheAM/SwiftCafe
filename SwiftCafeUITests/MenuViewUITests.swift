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
    
//    MARK: - Setup
    override func setUpWithError() throws {
        app.launchWithEnvironment()
    }
    
//    MARK: - Tests
    func testSectionSelectorsExist() throws {
        XCTAssert(app.buttons["Section 1"].exists)
        XCTAssert(app.buttons["Section 2"].exists)
    }
    
    func testFoodCardsExist() throws {
        XCTAssert(app.buttons["Food 1"].exists)
    }
    
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
