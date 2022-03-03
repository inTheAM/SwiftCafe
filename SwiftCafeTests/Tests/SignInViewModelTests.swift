//
//  SignInViewModelTests.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
@testable import SwiftCafe
import XCTest

/// #Tests the SignInViewModel.
final class SignInViewModelTests: XCTestCase {

    /// The view model under test.
    private var viewModel: SignInViewModel!

// MARK: - Setup
    /// Sets up the view model with a mock authentication service.
    override func setUpWithError() throws {
        viewModel = SignInViewModel(authService: MockAuthService.shared)
    }

// MARK: - Form Validation Tests
    /// Tests whether the view model validates form when both email and password inputs are filled.
    func testFormIsValidatedWithFilledInputs() throws {
        let isFormValidPublisher = viewModel.$isFormValid
            .dropFirst()
            .first()

        viewModel.email = "email"
        viewModel.password = "123"

        let isFormValid = try awaitResult(from: isFormValidPublisher)
        XCTAssertTrue(isFormValid)
    }

    /// Tests whether the view model does not validate the form when the email input is empty.
    func testFormValidationWithEmptyEmail() throws {
        let isFormValidPublisher = viewModel.$isFormValid
            .dropFirst()
            .first()

        viewModel.email = ""
        viewModel.password = "123"

        let isFormValid = try awaitResult(from: isFormValidPublisher)
        XCTAssertFalse(isFormValid)
    }

    /// Tests whether the view model does not validate the form when the password input is empty.
    func testFormValidationWithEmptyPassword() throws {
        let isFormValidPublisher = viewModel.$isFormValid
            .dropFirst()
            .first()

        viewModel.email = "email"
        viewModel.password = ""

        let isFormValid = try awaitResult(from: isFormValidPublisher)
        XCTAssertFalse(isFormValid)
    }

// MARK: - Form Error Tests
    /// Tests whether the inline error is correctly updated for an empty email input.
    func testSignInErrorWithEmptyEmail() throws {
        let signInErrorPublisher = viewModel.$signInErrorDescription
            .dropFirst()
            .first()

        viewModel.email = ""
        viewModel.password = "123"

        let error = try awaitResult(from: signInErrorPublisher)
        XCTAssertEqual(error, FormStatus.emailEmpty.description)
    }

    /// Tests whether the inline error is correctly updated for an empty password input.
    func testSignInErrorWithEmptyPassword() throws {
        let signInErrorPublisher = viewModel.$signInErrorDescription
            .dropFirst()
            .first()

        viewModel.email = "someemail"
        viewModel.password = ""

        let error = try awaitResult(from: signInErrorPublisher)
        XCTAssertEqual(error, FormStatus.passwordEmpty.description)
    }

    /// Tests whether the inline error is correctly updated for filled email and password inputs.
    func testSignInErrorWithFilledInputs() throws {
        let signInErrorPublisher = viewModel.$signInErrorDescription
            .dropFirst()
            .first()

        viewModel.email = "email"
        viewModel.password = "123"

        let error = try awaitResult(from: signInErrorPublisher)
        XCTAssertEqual(error, FormStatus.valid.description)
    }

// MARK: - SignIn Tests
    /// Tests signing in a user with valid credentials.
    func testSigningInWithValidCredentials() throws {
        viewModel.email = User.sample.email
        viewModel.password = User.sample.password

        let expectation = XCTestExpectation(description: "Sign in was successful")

        viewModel.signIn {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    /// Tests signing in a user with a non-registered email address.
    func testSigningInWithInvalidCredentials() throws {
        viewModel.email = "wrongemail@gmail.com"
        viewModel.password = "Passwordetc"

        let expectation = XCTestExpectation(description: "Signed in successfully")
        expectation.isInverted = true

        viewModel.signIn {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

// MARK: - Sign In Error Tests
    /// Tests whether the inline error is correctly updated for a failed sign-in.
    func testFailedSignInUpdatesInlineError() throws {
        let signInErrorPublisher = viewModel.$signInErrorDescription
            .dropFirst()
            .first()

        viewModel.email = "wrongemail@gmail.com"
        viewModel.password = "Passwordetc"

        viewModel.signIn {}

        let error = try awaitResult(from: signInErrorPublisher)

        XCTAssertEqual(error, AuthResult.invalidUsernameOrPassword.description)
    }

// MARK: - Teardown
    /// Tears down the test view model.
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
