//
//  SignUpViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import XCTest

/// #Tests the SignUpView.
final class SignUpViewUITests: XCTestCase {
    /// The test application instance.
    let app = XCUIApplication()

    // MARK: - Setup
    /// Launches the application in a test environment for sign-up testing and
    /// navigates to the sign-up view.
    override func setUpWithError() throws {
        app.launchInTestEnvironment(isSignup: true)
        let signUpLink = app.buttons["go to signup"]
        signUpLink.tap()
    }

    // MARK: - Tests
    /// Tests the navigation title exists.
    func testNavigationTitleExists() throws {
        let navTitle = app.navigationBars.staticTexts["Sign up"]
        XCTAssert(navTitle.exists)
    }

    /// Tests the email address input field exists.
    func testEmailTextFieldExists() throws {
        let emailField = app.textFields["email input"]
        XCTAssert(emailField.exists)
    }

    /// Tests the password secure fields appear when the email address input is validated.
    func testPasswordTextFieldsAppearOnEmailValidation() throws {
        let emailField = app.textFields["email input"]
        emailField.tap()
        emailField.typeText("testuser3@test.com")

        let passwordField = app.secureTextFields["password input"]
        let repeatPasswordField = app.secureTextFields["repeat password"]
        XCTAssert(passwordField.waitForExistence(timeout: 5))
        XCTAssert(repeatPasswordField.exists)
    }

    /// Tests the `Sign up` button appears when the email address input is validated and
    /// that the button is disabled.
    func testSignUpButtonAppearsOnEmailValidationAndIsDisabledByDefault() throws {
        let emailField = app.textFields["email input"]
        emailField.tap()
        emailField.typeText("testuser3@test.com")

        let signupButton = app.buttons["sign up"]
        XCTAssert(signupButton.waitForExistence(timeout: 5))
        XCTAssertFalse(signupButton.isEnabled)
    }

    /// Tests the `Sign up` button is enabled when the form is validated.
    func testSignUpButtonIsEnabledWhenFormIsValidated() throws {
        let emailField = app.textFields["email input"]
        emailField.tap()
        emailField.typeText("testuser3@test.com")

        let passwordField = app.secureTextFields["password input"]
        passwordField.tap()
        passwordField.typeText("Password@123")

        let repeatPasswordField = app.secureTextFields["repeat password"]
        repeatPasswordField.tap()
        repeatPasswordField.typeText("Password@123")

        let signupButton = app.buttons["sign up"]
        XCTAssertTrue(signupButton.isEnabled)
    }

    // MARK: - Teardown
    /// Terminates the test application instance.
    override func tearDownWithError() throws {
        app.terminate()
    }
}
