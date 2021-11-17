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
    
//    MARK: - Setup
    override func setUpWithError() throws {
        let service = MockAuthService()
        viewModel = SignInViewModel(authService: service)
    }
    
//    MARK: - Form Validation Tests
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
    
//    MARK: - Form Error Tests
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
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
