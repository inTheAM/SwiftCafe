//
//  Extra.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #An extra option that can be added to an order.
struct Extra: Decodable {

    /// The name of the extra option.
    let name: String

    ///  The price of the extra option.
    let price: String
}
