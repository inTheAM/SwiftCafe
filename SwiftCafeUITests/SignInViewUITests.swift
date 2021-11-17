//
//  SignInViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import XCTest

final class SignInViewUITests: XCTestCase {
    let app = XCUIApplication()
    
//    MARK: - Setup
    override func setUpWithError() throws {
        app.launch()
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
    
    func testPasswordFieldExists() throws {
        let passwordField = app.secureTextFields["password input"]
        XCTAssert(passwordField.exists)
    }
    
    func testSignUpNavigationLinkExists() throws {
        let signUpLink = app.buttons["go to signup"]
        XCTAssert(signUpLink.exists)
    }
    
    func testSignInButtonExists() throws {
        let signInButton = app.buttons["sign in"]
        XCTAssert(signInButton.exists)
    }
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
