//
//  Option.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #An option for customizing a food order.
struct Option: Identifiable {

    /// The permanent identifier for the option.
    let id: UUID

    /// The name of the option.
    let name: String
    
    let priceDifference: Double
}

// MARK: - Codable conformance
extension Option: Decodable { }

// MARK: - Equatable conformance
extension Option: Equatable {

    /// Compares two options using their `id`.
    /// - Returns: A boolean indicating whether the two
    ///            options are the same.
    static func == (lhs: Option, rhs: Option) -> Bool {
        lhs.id == rhs.id
    }
}
