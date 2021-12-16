//
//  XCUIApplication+Environment.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import XCTest

extension XCUIApplication {
    /// Launches the application in a test environment.
    /// - Parameter isSignup: A boolean value indicating whether
    ///                       the test involves sign-up or sign-in.
    func launchInTestEnvironment(isSignup: Bool = false) {
        if isSignup {
            self.launchEnvironment = ["ENV": "TEST_SIGNUP"]
        } else {
            self.launchEnvironment = ["ENV": "TEST"]
        }
        self.launch()
    }
}
