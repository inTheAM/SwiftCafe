//
//  MockMenuService.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation
@testable import SwiftCafe

struct MockMenuService: MenuServiceProtocol {
    func fetchMenu(completion: @escaping (Result<[MenuSection], RequestError>) -> Void) {
        completion(.success(MenuSection.samples))
    }
}
