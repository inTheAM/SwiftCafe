//
//  Cart.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Combine
import Foundation

/// #The user's cart.
struct Cart: Decodable {
    
    /// The cartContents of the cart.
    ///
    /// Sent as an array of `Payload` forms of a `CartEntry`.
    let contents: [Cart.Entry]
}

extension Cart {
    /// #An entry in the cart.
    struct Entry: Identifiable, Decodable {

        /// The permanent identifier for the cart entry.
        let id: UUID

        /// The food item in the cart entry.
        let food: Food

        /// The options selected
        let options: [Option]

        /// The quantity of the food item in the entry.
        let quantity: Int
    }
}

extension Cart.Entry {
    typealias Quantity = Int
    /// The data used to create a cart entry.
    struct CreateData: Encodable {

        /// The identifier for the food item to create an entry for.
        let foodID: Food.ID

        /// The options selected
        let options: [Option.ID]

        /// The quantity of the food item in the entry.
        let quantity: Quantity
    }

    /// The data used to remove a cart entry.
    struct RemoveData: Encodable {

        /// The id of the cart entry to remove from the user's cart.
        let id: Cart.Entry.ID
    }
}
