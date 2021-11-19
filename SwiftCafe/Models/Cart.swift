//
//  Cart.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation

final class Cart: ObservableObject {
    private let cartService: CartServiceProtocol

// MARK: - Cart contents
    @Published var contents = [Cart.Entry]()
    @Published var isLoading = false
    @Published var isModifying = false

// MARK: - Initializer
    init(cartService: CartServiceProtocol = CartServiceFactory.create()) {
        self.cartService = cartService
    }
}

extension Cart {
    struct Entry: Identifiable, Codable {
        let id: UUID
        let food: Food
        let quantity: Int
    }
}

extension Cart.Entry {
    struct CreateData: Codable {
        let foodID: UUID
        let quantity: Int
    }

    struct RemoveData: Codable {
        let id: UUID
    }
}
