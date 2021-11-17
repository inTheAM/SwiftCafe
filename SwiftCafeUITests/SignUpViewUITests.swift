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
    
    func testPasswordTextFieldsAppearOnEmailValidation() throws {
        let email = app.textFields["email"]
        email.tap()
        email.typeText("testuser3@test.com")
        let password = app.secureTextFields["password"]
        let repeatPassword = app.secureTextFields["repeatpassword"]
        XCTAssert(password.waitForExistence(timeout: 1))
        XCTAssert(repeatPassword.exists)
    }
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
