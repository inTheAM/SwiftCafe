//
//  FoodDetailsService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation

protocol FoodDetailsServiceProtocol {
    func fetchOptions(for foodID: UUID, completion: @escaping (Result<[OptionGroup], RequestError>) -> Void)
}

struct FoodDetailsService: FoodDetailsServiceProtocol {
    private let path = "options"
    func fetchOptions(for foodID: UUID, completion: @escaping (Result<[OptionGroup], RequestError>) -> Void) {
        NetWorkManager.makeGetRequest([OptionGroup].self, path: path + foodID.uuidString, authType: .none) { result in
            switch result {
            case .success(let sections):
                completion(.success(sections))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
