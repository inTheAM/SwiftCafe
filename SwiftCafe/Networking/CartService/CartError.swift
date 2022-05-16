//
//  CartError.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 01/03/2022.
//

import Foundation

enum CartError: Error {
    case failedToFetchContents
    case failedToAddItem
    case failedToRemoveItem
    case failedToClearContents

    var description: String {
        switch self {
        case .failedToFetchContents:
            return "There was a problem fetching the cartContents of your cart."
        case .failedToAddItem:
            return "Failed to add item"
        case .failedToRemoveItem:
            return "Failed to remove item."
        case .failedToClearContents:
            return "Failed to clear the cart contents."
        }
    }
}
