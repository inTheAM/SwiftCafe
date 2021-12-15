//
//  CartService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation

/// #A service that handles the crud operations for the user's cart.
struct CartService: CartServiceProtocol {

    /// Makes a network request to fetch the contents of the user's cart.
    /// - Parameters:
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes the result of the request which may be
    ///                 an array of Cart.Entry or a RequestError.
    func fetchContents(completion: @escaping ContentsHandler) {
        NetWorkManager.makeGetRequest([Cart.Entry].self,
                                      path: "carts/contents",
                                      authType: .bearer
        ) { result in
            switch result {
            case .success(let cart):
                completion(.success(cart))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// Makes a network request to add an item to the user's cart.
    /// - Parameters:
    ///   - food: The item to add to the user's cart.
    ///   - quantity: The quantity of the item to add to the user's cart.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes the result of the request which may be
    ///                 a Cart.Entry or a RequestError.
    func addToCart(_ food: Food, quantity: Int, completion: @escaping AddItemHandler) {
        let entry = Cart.Entry.CreateData(foodID: food.id, quantity: quantity)
        NetWorkManager.makePostRequestWithReturn(sending: entry,
                                                 receiving: Cart.Entry.self,
                                                 path: "carts/add",
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

    /// Makes a network request to remove an entry from the user's cart.
    /// - Parameters:
    ///   - cartEntry: The entry to remove from the user's cart.
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes the result of the request which may be
    ///                 nothing or a RequestError.
    func removeFromCart(_ cartEntry: Cart.Entry, completion: @escaping RemoveItemHandler) {
        let cartEntry = Cart.Entry.RemoveData(id: cartEntry.id)

        NetWorkManager.makePostRequestWithoutReturn(sending: cartEntry,
                                                    path: "carts/remove",
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
