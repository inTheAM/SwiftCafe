//
//  MenuViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #The ViewModel that handles the `MenuView` screen.
final class MenuViewModel: ObservableObject {

    /// The service that handles requests for the view model.
    private let menuService: MenuServiceProtocol

// MARK: - Sections
    /// The sections in the menu
    @Published var sections = [MenuSection]()

    /// The currently selected section in the `MenuView` screen.
    @Published var activeSection = ""

// MARK: - Initializer
    /// The initializer for the view model.
    /// - Parameter menuService: An instance of a type that conforms to `MenuServiceProtocol`.
    ///                          The default value is the return of the create method defined on `MenuServiceFactory`.
    init(menuService: MenuServiceProtocol = MockMenuService() /*MenuServiceFactory.create()*/) {
        self.menuService = menuService
    }

    // MARK: - Fetching Menu
    /// Uses the `menuService` to fetch the menu.
    /// On success, the fetched sections are assigned to the `sections`
    /// and the `activeSection` is set to the first section in the array.
    func fetchMenu() {
        menuService.fetchMenu { [weak self] result in
            switch result {
            case .success(let sections):
                self?.sections = sections
                self?.activeSection = sections[0].name
            case .failure(let error):
                print("MenuService-Error", error.description)
            }
        }
    }
}
