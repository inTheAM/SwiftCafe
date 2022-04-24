//
//  MenuService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
import Foundation

/// #A service that handles fetching the menu.
struct MenuService: MenuServiceProtocol {

    private let networkManager: NetworkManager = NetworkManager()

    func fetchMenu() -> AnyPublisher<[MenuSection], RequestError> {
        networkManager.makeRequestPublisher(endpoint: .fetchMenu)
            .share()
            .eraseToAnyPublisher()
    }
}
