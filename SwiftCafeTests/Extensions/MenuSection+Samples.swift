//
//  MenuSection+Samples.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation
@testable import SwiftCafe

extension MenuSection {
    static let samples = createSections()
    
    static func createSections() -> [MenuSection] {
        var sections = [MenuSection]()
        for i in 1...3 {
            var section = MenuSection(id: UUID(), name: "section \(i)", items: [])
            section.items = Food.createItems()
            sections.append(section)
        }
        return sections
    }
    
}
