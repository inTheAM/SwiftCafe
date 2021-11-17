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
    
//    MARK: - Tests
    func testFetchingMenu() throws {
        viewModel.fetchMenu() {
            XCTAssertEqual(self.viewModel.sections.count, MenuSection.samples.count)
            XCTAssertEqual(self.viewModel.sections[0].id, MenuSection.samples[0].id)
            XCTAssertEqual(self.viewModel.sections[1].name, MenuSection.samples[1].name)
            XCTAssertEqual(self.viewModel.sections[2].items.last?.id, MenuSection.samples[2].items.last?.id)
        }
    }
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
