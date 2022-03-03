//
//  MockMenuService.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
import Foundation
@testable import SwiftCafe

/// #A mock implementation of `MenuService`.
struct MockMenuService: MenuServiceProtocol {

    /// Mocks fetching the menu by passing the sample menu sections.
    /// - Parameter completion: A closure the method runs to pass the sample sections.
    func fetchMenu() -> AnyPublisher<[MenuSection], RequestError> {
        Just(MenuSection.samples)
            .setFailureType(to: RequestError.self)
            .eraseToAnyPublisher()
    }
}
