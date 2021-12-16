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
}

// MARK: - Codable conformance
extension Option: Decodable { }

// MARK: - Equatable conformance
extension Option: Equatable {
    
}
