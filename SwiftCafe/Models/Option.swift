//
//  Option.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

struct Option: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
}
