//
//  SwiftCafeTests.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import XCTest
@testable import SwiftCafe

class SignUpViewModelTests: XCTestCase {
    var viewModel: SignUpViewModel!
    override func setUpWithError() throws {
        let service = MockAuthService()
        viewModel = SignUpViewModel(authService: service)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

}
