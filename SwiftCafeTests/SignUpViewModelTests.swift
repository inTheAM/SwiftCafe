//
//  SwiftCafeTests.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//
import Combine
@testable import SwiftCafe
import XCTest

final class SignUpViewModelTests: XCTestCase {
    var viewModel: SignUpViewModel!
    
//    MARK: - Setup
    override func setUpWithError() throws {
        let service = MockAuthService()
        viewModel = SignUpViewModel(authService: service)
    }
    
//    MARK: - Email Validation Tests
    func testEmailValidationWithValidEmail() throws {
        let isEmailValidPublisher = viewModel.$isEmailValid
            .dropFirst()
            .first()
        
        viewModel.email = "testuser1@test.com"
        let isEmailValid = try awaitResult(from: isEmailValidPublisher)
        XCTAssertTrue(isEmailValid)
    }

    func testEmailValidationWithInvalidEmail() throws {
        let isEmailValidPublisher = viewModel.$isEmailValid
            .dropFirst()
            .first()
        
        viewModel.email = "testuser@test.com"
        let isEmailValid = try awaitResult(from: isEmailValidPublisher)
        XCTAssertFalse(isEmailValid)
    }
    
//    MARK: - Email Error Tests
    func testEmailValidationInlineErrorForEmptyEmail() throws {
        let isEmailValidPublisher = viewModel.$emailErrorDescription
            .dropFirst()
            .first()
        
        viewModel.email = ""
        let error = try awaitResult(from: isEmailValidPublisher)
        XCTAssertEqual(error, EmailStatus.empty.rawValue)
    }
    
    func testEmailValidationInlineErrorForInvalidEmail() throws {
        let isEmailValidPublisher = viewModel.$emailErrorDescription
            .dropFirst()
            .first()
        
        viewModel.email = "testemail"
        let error = try awaitResult(from: isEmailValidPublisher)
        XCTAssertEqual(error, EmailStatus.invalid.rawValue)
    }
    
    func testEmailValidationInlineErrorForUnavailableEmail() throws {
        let isEmailValidPublisher = viewModel.$emailErrorDescription
            .dropFirst()
            .first()
        
        viewModel.email = "testuser@test.com"
        let error = try awaitResult(from: isEmailValidPublisher)
        XCTAssertEqual(error, EmailStatus.unavailable.rawValue)
    }
    
    func testEmailValidationInlineErrorForValidEmail() throws {
        let isEmailValidPublisher = viewModel.$emailErrorDescription
            .dropFirst()
            .first()
        
        viewModel.email = "testuser3@test.com"
        let error = try awaitResult(from: isEmailValidPublisher)
        XCTAssertEqual(error, EmailStatus.valid.rawValue)
    }
    
//    MARK: - Password Validation Tests
    func testPasswordValidationWithValidPassword() throws {
        let isPasswordValidPublisher = viewModel.$isPasswordValid
            .dropFirst()
            .first()
        viewModel.password = "Password@123"
        viewModel.repeatedPassword = "Password@123"
        
        let isPasswordValid = try awaitResult(from: isPasswordValidPublisher)
        XCTAssertTrue(isPasswordValid)
    }
    
    func testPasswordValidationWithWeakPassword() throws {
        let isPasswordValidPublisher = viewModel.$isPasswordValid
            .dropFirst()
            .first()
        viewModel.password = "Password@"
        viewModel.repeatedPassword = "Password@"
        
        let isPasswordValid = try awaitResult(from: isPasswordValidPublisher)
        XCTAssertFalse(isPasswordValid)
    }
    
    func testPasswordValidationWithDifferentPasswords() throws {
        let isPasswordValidPublisher = viewModel.$isPasswordValid
            .dropFirst()
            .first()
        viewModel.password = "Password@"
        viewModel.repeatedPassword = "password2"
        
        let isPasswordValid = try awaitResult(from: isPasswordValidPublisher)
        XCTAssertFalse(isPasswordValid)
    }
    
//    MARK: - Password Error Tests
    func testPasswordValidationInlineErrorForEmptyPassword() throws {
        let isPasswordEmptyPublisher = viewModel.$passwordErrorDescription
            .dropFirst()
            .first()
        
        viewModel.password = ""
        viewModel.repeatedPassword = ""
        let error = try awaitResult(from: isPasswordEmptyPublisher)
        XCTAssertEqual(error, PasswordStatus.empty.rawValue)
    }
    
    func testPasswordValidationInlineErrorForWeakPassword() throws {
        let isPasswordWeakPublisher = viewModel.$passwordErrorDescription
            .dropFirst()
            .first()
        
        viewModel.password = "password"
        viewModel.repeatedPassword = "password"
        
        let error = try awaitResult(from: isPasswordWeakPublisher)
        XCTAssertEqual(error, PasswordStatus.weak.rawValue)
    }
    
    func testPasswordValidationInlineErrorForDifferentPasswords() throws {
        let passwordsDoNotMatchPublisher = viewModel.$passwordErrorDescription
            .dropFirst()
            .first()
        
        viewModel.password = "password123!"
        viewModel.repeatedPassword = "password213@"
        
        let error = try awaitResult(from: passwordsDoNotMatchPublisher)
        XCTAssertEqual(error, PasswordStatus.passwordsDoNotMatch.rawValue)
    }
    
    func testPasswordValidationInlineErrorForShortPassword() throws {
        let isPasswordShortPublisher = viewModel.$passwordErrorDescription
            .dropFirst()
            .first()
        
        viewModel.password = "acsd"
        viewModel.repeatedPassword = "acsd"
        let error = try awaitResult(from: isPasswordShortPublisher)
        XCTAssertEqual(error, PasswordStatus.short.rawValue)
    }
    
//    MARK: - Form Validation Tests
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
    
//    MARK: - SignUp Tests
    func testSigningUpWithValidCredentials() throws {
        viewModel.email = "wrongemail@gmail.com"
        viewModel.password = "Passwordetc"
        var isSignedIn = false
        viewModel.signUp {
            isSignedIn = true
        }
        XCTAssertTrue(isSignedIn)
    }
    
    func testSigningUpWithInvalidCredentials() throws {
        viewModel.email = User.sample.email
        viewModel.password = User.sample.password
        var isSignedIn = false
        viewModel.signUp {
            isSignedIn = true
        }
        XCTAssertFalse(isSignedIn)
    }
    
//    MARK: Teardown
    override func tearDownWithError() throws {
        viewModel = nil
    }

}
