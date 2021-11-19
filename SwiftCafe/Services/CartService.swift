//
//  CartService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation

protocol CartServiceProtocol {
    func fetchContents(completion: @escaping (Result<[Cart.Entry], RequestError>) -> Void)
    func addToCart(_ food: Food, quantity: Int, completion: @escaping (Result<Cart.Entry, RequestError>) -> Void)
    func removeFromCart(_ cartEntry: Cart.Entry, completion: @escaping (Result<Void, RequestError>) -> Void)
}

struct CartService: CartServiceProtocol {
    private let path = "carts"

    func fetchContents(completion: @escaping (Result<[Cart.Entry], RequestError>) -> Void) {
        NetWorkManager.makeGetRequest([Cart.Entry].self, path: path + "/cart", authType: .bearer) { result in
            switch result {
            case .success(let cart):
                completion(.success(cart))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func addToCart(_ food: Food, quantity: Int, completion: @escaping (Result<Cart.Entry, RequestError>) -> Void) {
        let entry = Cart.Entry.CreateData(foodID: food.id, quantity: quantity)
        NetWorkManager.makePostRequestWithReturn(sending: entry,
                                                 receiving: Cart.Entry.self,
                                                 path: path + "/add",
                                                 authType: .bearer
        ) { result in
            switch result {
            case .success(let cartEntry):
                completion(.success(cartEntry))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func removeFromCart(_ cartEntry: Cart.Entry, completion: @escaping (Result<Void, RequestError>) -> Void) {
        let cartEntry = Cart.Entry.RemoveData(id: cartEntry.id)

        NetWorkManager.makePostRequestWithoutReturn(sending: cartEntry,
                                                    path: path + "/remove",
                                                    authType: .bearer
        ) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
