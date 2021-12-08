//
//  FoodDetailsViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation

final class FoodDetailsViewModel: ObservableObject {
    private let service: FoodDetailsServiceProtocol
    @Published var food: Food
    @Published var quantity = 1

    var name: String {
        food.name
    }
    var details: String {
        food.details
    }
    var options: [OptionGroup] {
        food.options
    }
    var imageURL: String {
        food.imageURL
    }
    var stockQuantity: Int {
        food.stockQuantity
    }
    var price: String {
        "$\(food.price)"
    }
    var totalPrice: String {
        "$\(food.price * quantity)"
    }

    init(food: Food, service: FoodDetailsServiceProtocol = FoodDetailsServiceFactory.create()) {
        self.service = service
        self.food = food
    }

    func fetchOptions() {
        service.fetchOptions(for: food.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let options):
                    self.food.options.append(contentsOf: options)
                    print(self.food.options)
                case .failure(let error):
                    print("Food service error: ", error.rawValue)
                }
            }
        }
    }
}
