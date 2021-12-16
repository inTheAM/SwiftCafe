//
//  FoodDetailsViewModelTests.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

@testable import SwiftCafe
import XCTest

/// #Tests the FoodDetailsViewModel.
final class FoodDetailsViewModelTests: XCTestCase {

    /// The view model under test.
    private var viewModel: FoodDetailsViewModel!

// MARK: - Setup
    /// Sets up the view model with a mock food details service
    /// and a sample food item.
    override func setUpWithError() throws {
        let mockService = MockFoodDetailsService()
        let food = MenuSection.samples[0].items[0]

        viewModel = FoodDetailsViewModel(food: food, service: mockService)
    }

    // MARK: - Tests
    /// Tests fetching options for the food item.
    func testFetchingOptions() throws {
        let optionsPublisher = viewModel.$optionGroups
            .dropFirst()
            .first()

        viewModel.fetchOptions()

        let options = try awaitResult(from: optionsPublisher)
        XCTAssertEqual(options.count, OptionGroup.samples.count)
        XCTAssertEqual(options[0].name, OptionGroup.samples[0].name)
    }

    // MARK: - Teardown
    /// Tears down the test view model.
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
