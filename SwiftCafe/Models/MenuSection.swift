//
//  MenuSection.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

struct MenuSection:    Identifiable,    Codable    {
    var id:    UUID
    var name:    String
    var items: [Food]
}

extension MenuSection: Equatable    {
    static func    ==(lhs:    MenuSection,    rhs:    MenuSection)    ->    Bool    {
        lhs.id    ==    rhs.id
    }
}
