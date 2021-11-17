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
        let signUpLink = app.buttons["go to signup"]
        signUpLink.tap()
    }
    
//    MARK: - Tests
    func testSwiftCafeTextExists() throws {
        let text = app.staticTexts["SwiftCafe"]
        XCTAssert(text.exists)
    }
    
    func testSwiftCafeLogoExists() throws {
        let image = app.images["logo"]
        XCTAssert(image.exists)
    }
    
    func testEmailTextFieldExists() throws {
        let emailField = app.textFields["email input"]
        XCTAssert(emailField.exists)
    }
    
    func testPasswordTextFieldsAppearOnEmailValidation() throws {
        let emailField = app.textFields["email input"]
        emailField.tap()
        emailField.typeText("testuser3@test.com")
        let passwordField = app.secureTextFields["password input"]
        let repeatPasswordField = app.secureTextFields["repeat password"]
        XCTAssert(passwordField.waitForExistence(timeout: 5))
        XCTAssert(repeatPasswordField.exists)
    }
    
    func testSignUpButtonAppearsOnEmailValidation() throws {
        let emailField = app.textFields["email input"]
        emailField.tap()
        emailField.typeText("testuser3@test.com")
        let signupButton = app.buttons["sign up"]
        XCTAssert(signupButton.waitForExistence(timeout: 1))
        XCTAssertFalse(signupButton.isEnabled)
    }
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
