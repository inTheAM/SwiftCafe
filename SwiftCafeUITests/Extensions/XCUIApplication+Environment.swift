//
//  XCUIApplication+Environment.swift
//  SwiftCafeUITests
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import XCTest

extension XCUIApplication {
    func launchWithTestEnvironment(isSignup: Bool = false) {
        if isSignup {
            self.launchEnvironment = ["ENV": "TEST_SIGNUP"]
        } else {
            self.launchEnvironment = ["ENV": "TEST"]
        }
        self.launch()
    }
}
