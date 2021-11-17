//
//  MenuService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

protocol MenuServiceProtocol {
    func fetchMenu(completion: @escaping (Result<[MenuSection], RequestError>) -> Void)
}

struct MenuService: MenuServiceProtocol {
    private let path = "menu"
    
    func fetchMenu(completion: @escaping (Result<[MenuSection], RequestError>) -> Void) {
        #warning("FIND A WAY TO EXTRACT DEBUG LOGIC")
        #if DEBUG
        let sections = [MenuSection(id: UUID(), name: "Section 1", items: []), MenuSection(id: UUID(), name: "Section 2", items: [])]
        completion(.success(sections))
        return
        #else
        NetWorkManager.makeGetRequest([MenuSection].self, path: path + "/sections", authType: .none) { result in
            switch result {
            case .success(let sections):
                completion(.success(sections))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        #endif
    }
}
