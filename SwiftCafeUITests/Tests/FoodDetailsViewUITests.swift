//
//  FoodDetailsViewUITests.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

@testable import SwiftCafe
import XCTest

final class FoodDetailsViewUITests: XCTestCase {
    let app = XCUIApplication()
    
//    MARK: - Setup
    override func setUpWithError() throws {
        app.launchInTestEnvironment()
    }
    
//    MARK: - Teardown
    override func tearDownWithError() throws {
        app.terminate()
    }
}
