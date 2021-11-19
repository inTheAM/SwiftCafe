//
//  Cart.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation

final class Cart: ObservableObject {
//    MARK: - Cart contents
    @Published var contents = [Cart.Entry]()
    @Published var isLoading = false
    @Published var isModifying = false
}


extension Cart {
    struct Entry: Identifiable {
        let id: UUID
        let food: Food
        let quantity: Int
    }
}

extension Cart.Entry {
    struct CreateData: Codable {
        let merchandiseID: UUID
        let quantity: Int
    }
    
    struct RemoveData: Codable {
        let id: UUID
    }
}
