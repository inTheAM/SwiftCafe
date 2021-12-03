//
//  OptionGroup+Samples.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation
@testable import SwiftCafe

extension OptionGroup {
    static let samples = createOptions()
    static func createOptions() -> [OptionGroup] {
        var groups = [OptionGroup]()
        for num in 1...Int.random(in: 2...4) {
            var group = OptionGroup(name: "Option group \(num)", options: [Option]())
            for index in 1...Int.random(in: 2...4) {
                group.options.append(Option(name: "Option \(index)"))
            }
            groups.append(group)
        }
        return groups
    }
}
