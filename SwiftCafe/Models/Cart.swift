//
//  Cart.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import Foundation

final class Cart: ObservableObject {
    private let cartService: CartServiceProtocol

// MARK: - Cart contents
    @Published var contents = [Cart.Entry]()
    @Published var isLoading = false
    @Published var isModifying = false

// MARK: - Initializer
    init(cartService: CartServiceProtocol = CartServiceFactory.create()) {
        self.cartService = cartService
    }
}

extension Cart {
    func fetchContents() {
        isLoading = true
        cartService.fetchContents { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contents):
                    self?.contents  =   contents
                    self?.isLoading = false

                case .failure:
                    self?.isLoading = false
                }
            }
        }
    }

    func addToCart(_ food: Food, quantity: Int) {
        isModifying = true
        cartService.addToCart(food, quantity: quantity) { [weak self] result in
            switch result {
            case .success(let cartEntry):
                    self?.contents.append(cartEntry)
                    self?.isModifying = false
            case .failure(let error):
                print(error.rawValue)
                self?.isModifying = false
                }
        }
    }

    func removeFromCart(_ food: Food) {
        isModifying = true
        if let index = contents.firstIndex(where: { $0.food.id == food.id }) {
            cartService.removeFromCart(contents[index]) { [weak self] result in
                switch result {
                case .success:
                    self?.contents.remove(at: index)
                    self?.isModifying = false
                case .failure:
                    self?.isModifying = false
                }
            }
        }
    }
}

extension Cart {
    struct Entry: Identifiable, Codable {
        let id: UUID
        let food: Food
        let quantity: Int
    }
}

extension Cart.Entry {
    struct CreateData: Codable {
        let foodID: UUID
        let quantity: Int
    }

    struct RemoveData: Codable {
        let id: UUID
    }
}
