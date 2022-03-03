//
//  SwiftCafeTests.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//
import Combine
@testable import SwiftCafe
import XCTest

/// #Tests the SignUpViewModel.
final class SignUpViewModelTests: XCTestCase {

    /// The view model under test.
    var viewModel: SignUpViewModel!

    // MARK: - Setup
    /// Sets up the view model with a mock authentication service.
    override func setUpWithError() throws {
        viewModel = SignUpViewModel(authService: MockAuthService.shared)
    }

    // MARK: - Email Validation Tests
    /// Tests whether the view model correctly validates a valid email input.
    func testEmailValidationWithValidEmail() throws {
        let isEmailValidPublisher = viewModel.$isEmailValid
            .dropFirst()
            .first()

        viewModel.email = "testuser1@test.com"

        let isEmailValid = try awaitResult(from: isEmailValidPublisher)
        XCTAssertTrue(isEmailValid)
    }

    /// Tests whether the view model does not validate an unavailable email address.
    func testEmailValidationWithUnavailableEmail() throws {
        let isEmailValidPublisher = viewModel.$isEmailValid
            .dropFirst()
            .first()

        viewModel.email = "testuser@test.com"

        let isEmailValid = try awaitResult(from: isEmailValidPublisher)
        XCTAssertFalse(isEmailValid)
    }

    // MARK: - Email Error Tests
    /// Tests whether the inline error is correctly updated for an empty email input.
    func testEmailValidationInlineErrorForEmptyEmail() throws {
        let isEmailValidPublisher = viewModel.$emailErrorDescription
            .dropFirst()
            .first()

        viewModel.email = ""

        let error = try awaitResult(from: isEmailValidPublisher)
        XCTAssertEqual(error, EmailInputStatus.empty.description)
    }

    /// Tests whether the inline error is correctly updated for an invalid email address format.
    func testEmailValidationInlineErrorForInvalidEmail() throws {
        let isEmailValidPublisher = viewModel.$emailErrorDescription
            .dropFirst()
            .first()

        viewModel.email = "testemail"

        let error = try awaitResult(from: isEmailValidPublisher)
        XCTAssertEqual(error, EmailInputStatus.invalid.description)
    }

    /// Tests whether the inline error is correctly updated for an unavailable email address.
    func testEmailValidationInlineErrorForUnavailableEmail() throws {
        let isEmailValidPublisher = viewModel.$emailErrorDescription
            .dropFirst()
            .first()

        viewModel.email = "testuser@test.com"

        let error = try awaitResult(from: isEmailValidPublisher)
        XCTAssertEqual(error, EmailCheckResult.unavailable.description)
    }

    /// Tests whether the inline error is correctly updated for a valid email input.
    func testEmailValidationInlineErrorForValidEmail() throws {
        let isEmailValidPublisher = viewModel.$emailErrorDescription
            .first()

        viewModel.email = "testuser3@test.com"

        let error = try awaitResult(from: isEmailValidPublisher)

        XCTAssertEqual(error, EmailInputStatus.valid.description)
    }

// MARK: - Password Validation Tests
    /// Tests whether the view model correctly validates valid password and repeated password inputs.
    func testPasswordValidationWithValidPassword() throws {
        let isPasswordValidPublisher = viewModel.$isPasswordValid
            .dropFirst()
            .first()
        viewModel.password = "Password@123"
        viewModel.repeatedPassword = "Password@123"

        let isPasswordValid = try awaitResult(from: isPasswordValidPublisher)
        XCTAssertTrue(isPasswordValid)
    }

    /// Tests whether a the view model does not validate a weak password.
    func testPasswordValidationWithWeakPassword() throws {
        let isPasswordValidPublisher = viewModel.$isPasswordValid
            .dropFirst()
            .first()
        viewModel.password = "Password@"
        viewModel.repeatedPassword = "Password@"

        let isPasswordValid = try awaitResult(from: isPasswordValidPublisher)
        XCTAssertFalse(isPasswordValid)
    }

    /// Tests whether a the view model does not validate when the password inputs do not match.
    func testPasswordValidationWithDifferentPasswords() throws {
        let isPasswordValidPublisher = viewModel.$isPasswordValid
            .dropFirst()
            .first()
        viewModel.password = "Password@"
        viewModel.repeatedPassword = "password2"

        let isPasswordValid = try awaitResult(from: isPasswordValidPublisher)
        XCTAssertFalse(isPasswordValid)
    }

// MARK: - Password Error Tests
    /// Tests whether the inline error is correctly updated for an empty password input.
    func testPasswordValidationInlineErrorForEmptyPassword() throws {
        let isPasswordEmptyPublisher = viewModel.$passwordErrorDescription
            .dropFirst()
            .first()

        viewModel.password = ""
        viewModel.repeatedPassword = ""

        let error = try awaitResult(from: isPasswordEmptyPublisher)
        XCTAssertEqual(error, PasswordInputStatus.empty.description)
    }

    /// Tests whether the inline error is correctly updated for a weak password.
    func testPasswordValidationInlineErrorForWeakPassword() throws {
        let isPasswordWeakPublisher = viewModel.$passwordErrorDescription
            .dropFirst()
            .first()

        viewModel.password = "password"
        viewModel.repeatedPassword = "password"

        let error = try awaitResult(from: isPasswordWeakPublisher)
        XCTAssertEqual(error, PasswordInputStatus.weak.description)
    }

    /// Tests whether the inline error is correctly updated when password inputs do not match.
    func testPasswordValidationInlineErrorForDifferentPasswords() throws {
        let passwordsDoNotMatchPublisher = viewModel.$passwordErrorDescription
            .dropFirst()
            .first()

        viewModel.password = "password123!"
        viewModel.repeatedPassword = "password213@"

        let error = try awaitResult(from: passwordsDoNotMatchPublisher)
        XCTAssertEqual(error, PasswordInputStatus.passwordsDoNotMatch.description)
    }

    /// Tests whether the inline error is correctly updated for a short password.
    func testPasswordValidationInlineErrorForShortPassword() throws {
        let isPasswordShortPublisher = viewModel.$passwordErrorDescription
            .dropFirst()
            .first()

        viewModel.password = "acsd"
        viewModel.repeatedPassword = "acsd"

        let error = try awaitResult(from: isPasswordShortPublisher)
        XCTAssertEqual(error, PasswordInputStatus.short.description)
    }

// MARK: - Form Validation Tests
    /// Tests whether the view model validates form when both email and password inputs are valid.
    func testFormIsValidatedWithCorrectInputs() throws {
        let isFormValidPublisher = viewModel.$isFormValid
            .dropFirst()
            .first()

        viewModel.email = "testemail@gmail.com"
        viewModel.password = "Password@123"
        viewModel.repeatedPassword = "Password@123"

        let isFormValid = try awaitResult(from: isFormValidPublisher)
        XCTAssertTrue(isFormValid)
    }

// MARK: - SignUp Tests
    /// Tests signing up a user with valid credentials.
    func testSigningUpWithValidCredentials() throws {
        let expectation = XCTestExpectation(description: "Sign up was successful")

        viewModel.email = "newemail@gmail.com"
        viewModel.password = "Passwordetc"

        viewModel.signUp {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    /// Tests signing up a user with an unavailable email address.
    func testSigningUpWithInvalidCredentials() throws {
        viewModel.email = User.sample.email
        viewModel.password = User.sample.password

        let expectation = XCTestExpectation(description: "Signed up successfully")
        expectation.isInverted = true

        viewModel.signUp {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    // MARK: - Sign Up Error Tests
    /// Tests whether the inline error is correctly updated for a failed sign-up.
    func testFailedSignUpUpdatesInlineError() throws {
        let signUpErrorPublisher = viewModel.$signUpErrorDescription
            .dropFirst()
            .first()
        viewModel.email = "fail@gmail.com"
        viewModel.password = "Passwordetc"
        viewModel.signUp {}

        let error = try awaitResult(from: signUpErrorPublisher)

        XCTAssertEqual(error, AuthResult.signUpFailed.description)
    }

    // MARK: Teardown
    /// Tears down the test view model.
    override func tearDownWithError() throws {
        viewModel = nil
    }

}
