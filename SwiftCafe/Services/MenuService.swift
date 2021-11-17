//
//  MenuService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

protocol MenuServiceProtocol {
    func fetchMenu(for outlet: UUID, completion: @escaping (Result<[MenuSection], RequestError>) -> Void)
}

struct MenuService: MenuServiceProtocol {
    private let path = "outlets"
    
    func fetchMenu(for outletID: UUID, completion: @escaping (Result<[MenuSection], RequestError>) -> Void) {
        NetWorkManager.makeGetRequest([MenuSection].self, path: path + "/\(outletID)/sections", authType: .none) { result in
            switch result {
            case .success(let sections):
                completion(.success(sections))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
