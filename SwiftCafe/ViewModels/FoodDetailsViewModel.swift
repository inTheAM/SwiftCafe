//
//  FoodDetailsViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Combine
import Foundation

final class FoodDetailsViewModel: ObservableObject {
    private let service: FoodDetailsServiceProtocol

// MARK: - Data
    @Published var food: Food
    @Published var quantity = 1
    @Published var selectedOptions = [Option]()

    @Published var selectionSummary: String = ""

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

    var cancellables = Set<AnyCancellable>()

    var selectionSummaryPublisher: AnyPublisher<String, Never> {
        Publishers.CombineLatest($quantity, $selectedOptions)
            .map { quantity, options in
                var optionsSummary = ""
                if !options.isEmpty {
                    optionsSummary += "with "
                }
                for (index, option) in options.enumerated() {
                    if index == 0 && options.count == 1 {
                        optionsSummary += "\(option.name)."
                    } else if index == options.count - 2 {
                        optionsSummary += "\(option.name) "
                    } else if index != options.count - 1 {
                        optionsSummary += "\(option.name), "
                    } else {
                        optionsSummary += "and \(option.name)."
                    }
                }
                return "\(quantity)x \(self.food.name) \(optionsSummary)"
            }
            .eraseToAnyPublisher()
    }

// MARK: - Initializer
    init(food: Food, service: FoodDetailsServiceProtocol = FoodDetailsServiceFactory.create()) {
        self.service = service
        self.food = food

        selectionSummaryPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.selectionSummary, on: self)
            .store(in: &cancellables)
    }

// MARK: - Fetching options
    func fetchOptions() {
        service.fetchOptions(for: food.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let options):
                    self.food.options.append(contentsOf: options)
                case .failure(let error):
                    print("Food service error: ", error.rawValue)
                }
            }
        }
    }

    func selectOption(_ option: Option) {
        if let optionGroup = options.first(where: {$0.options.contains(option)}) {
            for selectedOption in optionGroup.options where selectedOptions.contains(selectedOption) {
                if let index = selectedOptions.firstIndex(of: selectedOption) {
                    selectedOptions.remove(at: index)
                }
            }
            selectedOptions.append(option)
        }
    }

    func removeOption(_ option: Option?) {
        if let option = option, let index = selectedOptions.firstIndex(of: option) {
            selectedOptions.remove(at: index)
        }
    }
}
