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
    
//    MARK: - Setup
    override func setUpWithError() throws {
        let service = MockFoodDetailsService()
        viewModel = FoodDetailsViewModel(service: service)
    }
    
//    MARK: - Tests
    func testFetchingOptions() throws {
        viewModel.fetchOptions()
        XCTAssertEqual(viewModel.options.count, OptionGroup.samples.count)
        XCTAssertEqual(viewModel.options[0].name, OptionGroup.samples[0].name)
    }
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        viewModel = nil
    }
}
