//
//  MenuViewModelTests.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

@testable import SwiftCafe
import XCTest

final class MenuViewModelTests: XCTestCase {
    private var viewModel: MenuViewModel!
    
//    MARK: - Setup
    override func setUpWithError() throws {
        let menuService = MockMenuService()
        viewModel = MenuViewModel(menuService: menuService)
    }
    
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
