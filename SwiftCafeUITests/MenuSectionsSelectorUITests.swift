//
//  MenuSectionsSelectorUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

@testable import SwiftCafe
import XCTest

final class MenuSectionsSelectorUITests: XCTestCase {
    let app = XCUIApplication()
    
//    MARK: - Setup
    override func setUpWithError() throws {
        app.launch()
    }
    
//    MARK: - Tests
    func testSectionSelectorsExist() throws {
        XCTAssert(app.buttons["Section 1"].exists)
        XCTAssert(app.buttons["Section 2"].exists)
    }
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
