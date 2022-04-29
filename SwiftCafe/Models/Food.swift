//
//  Food.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #A food item.
struct Food: Identifiable {

    /// The permanent identifier for the food item.
    /// Satisfies conformance to Identifiable
    let id: UUID

    /// The name of the food.
    let name: String

    /// The description of the food.
    let details: String

    /// The price for the food.
    let price: Double

    /// The url for the image showing the food.
    let imageURL: String
}

// MARK: - Equatable conformance.
extension Food: Equatable {

    /// Compares two food items using their `id`.
    /// - Returns: A boolean indicating whether the two
    ///            food items are the same.
    static func == (lhs: Food, rhs: Food) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Codable conformance.
extension Food: Codable { }
