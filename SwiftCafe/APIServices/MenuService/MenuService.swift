//
//  MenuService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #A service that handles fetching the menu.
struct MenuService: MenuServiceProtocol {

    /// Makes a network request to fetch the menu.
    /// - Parameter completion: A closure the method runs when a result is received from the request.
    ///                         The closure takes a Result containing either an array of MenuSection or a RequestError.
    func fetchMenu(completion: @escaping MenuHandler) {
        NetWorkManager.makeGetRequest([MenuSection].self,
                                      path: "menu",
                                      authType: .none
        ) { result in
            switch result {
            case .success(let sections):
                completion(.success(sections))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
