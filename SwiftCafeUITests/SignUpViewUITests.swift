//
//  SignUpViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import XCTest

final class SignUpViewUITests: XCTestCase {
    let app = XCUIApplication()
    
//    MARK: - Setup
    override func setUpWithError() throws {
        app.launch()
    }
    
//    MARK: - Tests
    func testEmailTextFieldExists() throws {
        let email = app.textFields["email"]
        XCTAssert(email.exists)
    }
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
