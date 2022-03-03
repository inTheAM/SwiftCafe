//
//  MenuViewModelTests.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

@testable import SwiftCafe
import XCTest

/// #Tests the MenuViewModel.
final class MenuViewModelTests: XCTestCase {

    /// The view model under test.
    private var viewModel: MenuViewModel!

    // MARK: - Setup
    /// Sets up the viewModel with a mock menu service.
    override func setUpWithError() throws {
        let mockService = MockMenuService()
        viewModel = MenuViewModel(menuService: mockService)
    }

    // MARK: - Tests
    /// Tests fetching the menu
    func testFetchingMenu() throws {
        let sectionsPublisher = viewModel.$sections
            .dropFirst()
            .first()
        let activeSectionPublisher = viewModel.$activeSection
            .first()

        viewModel.fetchMenu()

        let sections = try awaitResult(from: sectionsPublisher)
        let activeSection = try awaitResult(from: activeSectionPublisher)
print(activeSection)
        XCTAssertEqual(sections.count, MenuSection.samples.count)
        XCTAssertEqual(sections[0].id, MenuSection.samples[0].id)
        XCTAssertEqual(activeSection, MenuSection.samples[0].name)
        XCTAssertEqual(sections[1].name, MenuSection.samples[1].name)
        XCTAssertEqual(sections[2].items.last?.id, MenuSection.samples[2].items.last?.id)
    }

    // MARK: - Teardown
    /// Tears down the test view model.
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
