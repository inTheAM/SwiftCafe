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

    override func tearDownWithError() throws {
        viewModel = nil
    }

}
