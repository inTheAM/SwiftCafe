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
    
    override func tearDownWithError() throws {
        viewModel = nil
    }

}
