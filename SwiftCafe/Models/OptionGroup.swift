//
//  OptionGroup.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #A group of options to customize a food item before
/// #adding it to the user's cart.
/// #Only one option can be selected at a time.
struct OptionGroup: Decodable {
    
    /// The name for the group of options.
    let name: String
    
    /// The options to select from.
    let options: [Option]
}
