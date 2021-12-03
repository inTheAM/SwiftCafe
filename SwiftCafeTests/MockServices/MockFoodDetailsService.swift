//
//  MockFoodDetailsService.swift
//  SwiftCafeTests
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation
@testable import SwiftCafe

struct MockFoodDetailsService: FoodDetailsServiceProtocol {
    func fetchOptions(for foodID: UUID, completion: @escaping (Result<[OptionGroup], RequestError>) -> Void) {
        completion(.success(OptionGroup.samples))
    }
}
