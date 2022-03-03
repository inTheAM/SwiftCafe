//
//  FoodDetailsViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Combine
import Foundation

/// #The View Model for the `FoodDetailsView` screen.
final class FoodDetailsViewModel: ObservableObject {
    /// The service that handles requests for this view model.
    private let foodDetailsService: FoodDetailsServiceProtocol

    /// The cancellables set that stores the publishers in this view model.
    var cancellables = Set<AnyCancellable>()

    // MARK: - Data
    /// The `Food` instance handled by this view model.
    @Published var food: Food

    /// The option groups for this food item.
    @Published var optionGroups = [OptionGroup]()

    /// The quantity of the `Food` Item to add to the user's cart.
    @Published var quantity = 1

    /// The selected options for the `Food` item to add to the user's cart.
    @Published var selectedOptions = [Option]()

    /// A String describing the `Food`, quantity and options selected.
    @Published var selectionSummary: String = ""

    @Published private(set) var error: String?

// MARK: - Computed properties of the Food instance
    /// The name of the food.
    var name: String {
        food.name
    }
    /// The details of the food.
    var details: String {
        food.details
    }
    /// The url for the image showing the food
    var imageURL: String {
        food.imageURL
    }
    /// The stock quantity available for this food
    var stockQuantity: Int {
        food.stockQuantity
    }
    /// A string describing the food price
    var price: String {
        "$\(food.price)"
    }
    /// A string representing the total price accommodating for the quantity and any extras.
    var totalPrice: String {
        "$\(food.price * quantity)"
    }

    // MARK: - Initializer
    /// The initializer for the view model.
    /// - Parameters:
    ///   - food: The food to load data for
    ///   - service: An instance of a type that conforms to `FoodDetailsServiceProtocol`.
    ///              The default value is the return of the create method defined on `FoodDetailsServiceFactory`.
    init(food: Food, service: FoodDetailsServiceProtocol = FoodDetailsServiceFactory.create()) {
        self.foodDetailsService = service
        self.food = food

        /// Initializing the selection summary publisher.
        /// The publisher is received on the main thread, assigned to `selectionSummary`
        /// and stored in the `cancellables` set.
        selectionSummaryPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.selectionSummary, on: self)
            .store(in: &cancellables)
    }

// MARK: - Selection summary
    /// A publisher that combines `quantity` and `selectedOptions`.
    /// Returns a String containing a summary for the food,
    /// options and quantity to add to cart.
    var selectionSummaryPublisher: AnyPublisher<String, Never> {
        Publishers.CombineLatest($quantity, $selectedOptions)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { quantity, options in
                var summary = ""
                summary += "\(quantity)x \(self.food.name) "
                if !options.isEmpty {
                    summary += "with "
                }
                for (index, option) in options.enumerated() {
                    if index == 0 && options.count == 1 {
                        summary += "\(option.name)."
                    } else if index == options.count - 2 {
                        summary += "\(option.name) "
                    } else if index != options.count - 1 {
                        summary += "\(option.name), "
                    } else {
                        summary += "and \(option.name)."
                    }
                }
                return summary
            }
            .eraseToAnyPublisher()
    }

// MARK: - Fetching options
    /// Uses the `foodDetailsService` to fetch the options for the food for this view model.
    /// On success, the fetched options are assigned to the `options` array.
    func fetchOptions() {
        foodDetailsService.fetchOptions(for: food.id)
            .retry(3)
            .catch { error ->  AnyPublisher<[OptionGroup], Never> in
                self.error = "Failed to load options for this item"
                return Just([OptionGroup]())
                    .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .assign(to: \.optionGroups, on: self)
            .store(in: &cancellables)
    }

// MARK: - Selecting options
    /// Selects an option for this food.
    /// If an option in the same option group is already selected,
    /// the existing selection is overwritten by the new option.
    /// - Parameter option: An option to mark for selection.
    func selectOption(_ option: Option) {
        if let optionGroup = optionGroups.first(where: {$0.options.contains(option)}) {
            for selectedOption in optionGroup.options where selectedOptions.contains(selectedOption) {
                if let index = selectedOptions.firstIndex(of: selectedOption) {
                    selectedOptions.remove(at: index)
                }
            }
            selectedOptions.append(option)
        }
    }

// MARK: - Deselecting options
    /// Deselects an option for this food.
    /// - Parameter option: The option to remove from `selectedOptions`
    func removeOption(_ option: Option?) {
        if let option = option,
           let index = selectedOptions.firstIndex(of: option) {
            selectedOptions.remove(at: index)
        }
    }
}
