//
//  Food+Samples.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation
@testable import SwiftCafe

extension Food {
    static func createItems() -> [Food] {
        var items = [Food]()
        for num in 1...Int.random(in: 3...6) {
            items.append(Food(id: UUID(), name: "Food \(num)", details: "Food details", options: [], extras: [], price: 1000, imageURL: "", stockQuantity: 20))
        }
        return items
    }
}
