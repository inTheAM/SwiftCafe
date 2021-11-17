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
    
    
    
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
