//
//  SignInViewModelTests.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
@testable import SwiftCafe
import XCTest

final class SignInViewModelTests: XCTestCase {
    private var viewModel: SignInViewModel!

// MARK: - Setup
    override func setUpWithError() throws {
        let service = MockAuthService()
        viewModel = SignInViewModel(authService: service)
    }

// MARK: - Form Validation Tests
    func testFormIsValidatedWithFilledInputs() throws {
        let isFormValidPublisher = viewModel.$isFormValid
            .dropFirst()
            .first()

        viewModel.email = "email"
        viewModel.password = "123"

        let isFormValid = try awaitResult(from: isFormValidPublisher)
        XCTAssertTrue(isFormValid)
    }

    func testFormValidationWithEmptyEmail() throws {
        let isFormValidPublisher = viewModel.$isFormValid
            .dropFirst()
            .first()

        viewModel.email = ""
        viewModel.password = "123"

        let isFormValid = try awaitResult(from: isFormValidPublisher)
        XCTAssertFalse(isFormValid)
    }

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
    func testSignInErrorWithEmptyEmail() throws {
        let signInErrorPublisher = viewModel.$signInErrorDescription
            .dropFirst()
            .first()

        viewModel.email = ""
        viewModel.password = "123"

        let error = try awaitResult(from: signInErrorPublisher)
        XCTAssertEqual(error, FormStatus.emailEmpty.rawValue)
    }

    func testSignInErrorWithEmptyPassword() throws {
        let signInErrorPublisher = viewModel.$signInErrorDescription
            .dropFirst()
            .first()

        viewModel.email = "someemail"
        viewModel.password = ""

        let error = try awaitResult(from: signInErrorPublisher)
        XCTAssertEqual(error, FormStatus.passwordEmpty.rawValue)
    }

    func testSignInErrorWithFilledInputs() throws {
        let signInErrorPublisher = viewModel.$signInErrorDescription
            .dropFirst()
            .first()

        viewModel.email = "email"
        viewModel.password = "123"

        let error = try awaitResult(from: signInErrorPublisher)
        XCTAssertEqual(error, FormStatus.valid.rawValue)
    }

// MARK: - SignIn Tests
    func testSigningInWithValidCredentials() throws {
        viewModel.email = User.sample.email
        viewModel.password = User.sample.password
        let expectation = XCTestExpectation(description: "Sign in was successful")
        viewModel.signIn {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testSigningInWithInvalidCredentials() throws {
        viewModel.email = "wrongemail@gmail.com"
        viewModel.password = "Passwordetc"
        var isSignedIn = false
        viewModel.signIn {
            isSignedIn = true
        }
        XCTAssertFalse(isSignedIn)
    }

    func testFailedSignInUpdatesInlineError() throws {
        let signInErrorPublisher = viewModel.$signInErrorDescription
            .first()
        viewModel.email = "wrongemail@gmail.com"
        viewModel.password = "Passwordetc"
        viewModel.signIn {}

        let error = try awaitResult(from: signInErrorPublisher)
        XCTAssertEqual(error, AuthError.signInFailed.rawValue)
    }

// MARK: - Teardown
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
