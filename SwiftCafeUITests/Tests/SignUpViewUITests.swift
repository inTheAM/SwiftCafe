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
        let signUpLink = app.buttons["go-to-signup"]
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
        let emailField = app.textFields["sign-up-email-input"]
        XCTAssert(emailField.exists)
        emailField.tap()
        emailField.typeText("testing")
    }

    /// Tests the password secure fields appear when the email address input is validated.
    func testPasswordTextFieldsAppearOnEmailValidation() throws {
        let emailField = app.textFields["sign-up-email-input"]
        emailField.tap()
        emailField.typeText("testuser3@test.com")

        let passwordField = app.secureTextFields["sign-up-password-input"]
        let repeatPasswordField = app.secureTextFields["sign-up-repeat-password-input"]
        XCTAssert(passwordField.waitForExistence(timeout: 10))
        XCTAssert(repeatPasswordField.exists)
    }

    /// Tests the `Sign up` button appears when the email address input is validated and
    /// that the button is disabled.
    func testSignUpButtonAppearsOnEmailValidationAndIsDisabledByDefault() throws {
        let emailField = app.textFields["sign-up-email-input"]
        XCTAssert(emailField.waitForExistence(timeout: 10))
        emailField.tap()
        emailField.typeText("testuser3@test.com")
        print(app.debugDescription)
        sleep(2)
        let signupButton = app.buttons["sign-up-button"]

        XCTAssert(signupButton.waitForExistence(timeout: 10), app.debugDescription)

        XCTAssertFalse(signupButton.isEnabled)
    }

    /// Tests the `Sign up` button is enabled when the form is validated.
    func testSignUpButtonIsEnabledWhenFormIsValidated() throws {
        let emailField = app.textFields["sign-up-email-input"]
        emailField.tap()
        emailField.typeText("testuser3@test.com")

        let passwordField = app.secureTextFields["sign-up-password-input"]
        XCTAssert(passwordField.waitForExistence(timeout: 10))
        passwordField.tap()
        passwordField.typeText("Password@123")

        let repeatPasswordField = app.secureTextFields["sign-up-repeat-password-input"]
        repeatPasswordField.tap()
        repeatPasswordField.typeText("Password@123")
        print(app.debugDescription)
        let signupButton = app.buttons["sign-up-button"]
        XCTAssert(signupButton.waitForExistence(timeout: 10))
        XCTAssertTrue(signupButton.isEnabled)
    }

    // MARK: - Teardown
    /// Terminates the test application instance.
    override func tearDownWithError() throws {
        app.terminate()
    }
}
