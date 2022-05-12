//
//  OptionGroup+Samples.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation
@testable import SwiftCafe

extension OptionGroup {

    /// Sample option groups.
    static let samples = createOptions()

    /// Creates sample option groups.
    /// - Returns: An array of `OptionGroup`.
    static func createOptions() -> [OptionGroup] {
        var groups = [OptionGroup]()
        for num in 1...Int.random(in: 2...4) {
            let groupID = UUID()
            var options = [Option]()
            for index in 1...Int.random(in: 2...4) {
                options.append(
                    Option(id: UUID(),
                           name: "Option \(index)",
                           priceDifference: 0.5,
                           optionGroupID: groupID)
                )
            }

            let group = OptionGroup(id: groupID, name: "Option group \(num)", options: options)
            groups.append(group)
        }
        return groups
    }
}
