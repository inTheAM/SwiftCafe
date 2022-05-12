//
//  CartEntry+Samples.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation
@testable import SwiftCafe

extension Cart.Entry {

    /// Sample cart entries.
    static let samples = [
        Cart.Entry(id: UUID(), food: MenuSection.samples[0].items[0], options: [Option](), quantity: 3),
        Cart.Entry(id: UUID(), food: MenuSection.samples[1].items[0], options: [Option](), quantity: 2)
    ]
}
