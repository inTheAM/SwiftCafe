//
//  SignInViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import XCTest

/// #Tests the SignInView.
final class SignInViewUITests: XCTestCase {
    /// The test application instance.
    let app = XCUIApplication()

    // MARK: - Setup
    /// Launches the application in the test environment for sign-in testing.
    override func setUpWithError() throws {
        app.launchInTestEnvironment(isSignup: true)
    }

    // MARK: - Tests
    /// Tests the SwiftCafe label exists.
    func testSwiftCafeTextExists() throws {
        let text = app.staticTexts["SwiftCafe"]
        XCTAssert(text.exists)
    }

    /// Tests the SwiftCafe logo exists.
    func testSwiftCafeLogoExists() throws {
        let image = app.images["logo"]
        XCTAssert(image.exists)
    }

    /// Tests the email address input field exists.
    func testEmailTextFieldExists() throws {
        let emailField = app.textFields["email input"]
        XCTAssert(emailField.exists)
    }

    /// Tests the password secure field exists.
    func testPasswordFieldExists() throws {
        let passwordField = app.secureTextFields["password input"]
        XCTAssert(passwordField.exists)
    }

    /// Tests the navigation link to the sign-up page exists.
    func testSignUpNavigationLinkExists() throws {
        let signUpLink = app.buttons["go to signup"]
        XCTAssert(signUpLink.exists)
    }

    /// Tests the `Sign in` button exists and
    /// that the button disabled by default.
    func testSignInButtonExistsAndIsDisabledByDefault() throws {
        let signInButton = app.buttons["sign in"]
        XCTAssert(signInButton.exists)
    }

    /// Tests the `Sign up` button is enabled when the form is validated.
    func testSignInButtonIsEnabledWhenFormIsValidated() throws {
        let emailField = app.textFields["email input"]
        emailField.tap()
        emailField.typeText("testuser3@test.com")

        let passwordField = app.secureTextFields["password input"]
        passwordField.tap()
        passwordField.typeText("Password@123")

        let signinButton = app.buttons["sign in"]
        XCTAssert(signinButton.waitForExistence(timeout: 5))
        XCTAssertTrue(signinButton.isEnabled)
    }

    /// Tests navigating to the `SignUpView`.
    func testNavigatingToSignUpView() throws {
        let signUpLink = app.buttons["go to signup"]
        signUpLink.tap()
        XCTAssertFalse(signUpLink.waitForExistence(timeout: 5))
    }

    // MARK: - Teardown
    /// Terminates the test application instance.
    override func tearDownWithError() throws {
        app.terminate()
    }
}
