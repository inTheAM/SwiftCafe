//
//  MenuSection.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #A section of the Menu.
struct MenuSection: Identifiable {

    /// The permanent identifier for the section.
    /// Satisfies conformance to Identifiable
    let id: UUID

    /// The name of the section.
    let name: String

    /// The food items in the section.
    let items: [Food]
}

// MARK: - Codable conformance.
extension MenuSection: Decodable { }

// MARK: - Equatable conformance.
extension MenuSection: Equatable {
    
    /// Compares two menu sections using their `id`.
    /// - Returns: A boolean indicating whether the two
    ///            menu sections are the same.
    static func == (lhs: MenuSection, rhs: MenuSection) -> Bool {
        lhs.id == rhs.id
    }
}
