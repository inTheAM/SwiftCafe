//
//  MockCartService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation
@testable import SwiftCafe

struct MockCartService: CartServiceProtocol {
    func fetchCart(completion: @escaping (Result<[Cart.Entry], RequestError>) -> Void) {
        completion(.success(Cart.Entry.samples))
    }

    func addToCart(_ food: Food, quantity: Int, completion: @escaping (Result<Cart.Entry, RequestError>) -> Void) {
        let entry = Cart.Entry(id: UUID(), food: food, quantity: quantity)
        completion(.success(entry))
    }

    func removeFromCart(_ cartEntry: Cart.Entry, completion: @escaping (Result<Void, RequestError>) -> Void) {
        completion(.success(()))
    }
}
