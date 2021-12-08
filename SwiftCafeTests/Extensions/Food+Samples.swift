//
//  Food+Samples.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation
@testable import SwiftCafe
// swiftlint:disable line_length
extension Food {
    static func createItems() -> [Food] {
        var items = [Food]()
        for num in 1...Int.random(in: 3...6) {
            items.append(
                Food(id: UUID(),
                     name: "Food \(num)",
                     details: "Food details",
                     options: OptionGroup.createOptions(),
                     extras: [],
                     price: 12,
                     imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU",
                     stockQuantity: 20))
        }
        return items
    }
}
