//
//  MenuServiceProtocol.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Combine
import Foundation

/// #A protocol for services that handle fetching the menu.
protocol MenuServiceProtocol {
    /// Fetches an array of MenuSection.
    /// - Returns: A Publisher that publishes either an array of menu sections or a `RequestError`
    func fetchMenu() -> AnyPublisher<[MenuSection], RequestError>
}
