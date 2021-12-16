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
        for num in 1...3 {
            let section = MenuSection(id: UUID(), name: "Section \(num)", items: Food.createItems())
            sections.append(section)
        }
        return sections
    }

}
