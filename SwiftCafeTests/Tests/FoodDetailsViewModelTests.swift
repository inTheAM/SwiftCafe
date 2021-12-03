//
//  FoodDetailsViewModelTests.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

@testable import SwiftCafe
import XCTest

final class FoodDetailsViewModelTests: XCTestCase {
    private var viewModel: FoodDetailsViewModel!

// MARK: - Setup
    override func setUpWithError() throws {
        let service = MockFoodDetailsService()
        let food = MenuSection.samples[0].items[0]
        viewModel = FoodDetailsViewModel(food: food, service: service)
    }

// MARK: - Tests
    func testFetchingOptions() throws {
        let foodPublisher = viewModel.$food
            .dropFirst()
            .first()
        viewModel.fetchOptions()
        let food = try awaitResult(from: foodPublisher)
        XCTAssertEqual(food.options.count, OptionGroup.samples.count)
        XCTAssertEqual(food.options[0].name, OptionGroup.samples[0].name)
    }

// MARK: - Teardown
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
