//
//  MenuViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
import Foundation

/// #The ViewModel that handles the `MenuView` screen.
final class MenuViewModel: ObservableObject {

    /// The service that handles requests for the view model.
    private let menuService: MenuServiceProtocol

    private var cancellables: Set<AnyCancellable> = .init()

// MARK: - Sections
    /// The sections in the menu
    @Published var sections = [MenuSection]()

    /// The currently selected section in the `MenuView` screen.
    @Published var activeSection = ""

    @Published var error: String?

// MARK: - Initializer
    /// The initializer for the view model.
    /// - Parameter menuService: An instance of a type that conforms to `MenuServiceProtocol`.
    ///                          The default value is the return of the create method defined on `MenuServiceFactory`.
    init(menuService: MenuServiceProtocol = MenuServiceFactory.create()) {
        self.menuService = menuService

        $sections
            .receive(on: RunLoop.main)
            .compactMap { sections in
                sections.first?.name
            }
            .assign(to: \.activeSection, on: self)
            .store(in: &cancellables)
    }

    // MARK: - Fetching Menu
    /// Uses the `menuService` to fetch the menu.
    /// On success, the fetched sections are assigned to the `sections`
    /// and the `activeSection` is set to the first section in the array.
    func fetchMenu() {
        menuService.fetchMenu()
            .retry(3)
            .catch { error ->  AnyPublisher<[MenuSection], Never> in
                self.error = "Failed to load menu"
                return Just([MenuSection]())
                    .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .assign(to: \.sections, on: self)
            .store(in: &cancellables)
    }
}
