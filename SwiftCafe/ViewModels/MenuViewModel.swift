//
//  MenuViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

final class MenuViewModel: ObservableObject {
    private let menuService: MenuServiceProtocol
    
//    MARK: - Sections
    @Published var sections = [MenuSection]()
    @Published var activeSection = ""
    
//    MARK: - Initializer
    init(menuService: MenuServiceProtocol = MenuService()) {
        self.menuService = menuService
    }
    
//    MARK: - Fetching Menu
    func fetchMenu() {
        menuService.fetchMenu() { [weak self] result in
            switch result {
            case .success(let sections):
                self?.sections = sections
                self?.activeSection = sections[0].name
            case .failure(let error):
                print("MenuService-Error", error.rawValue)
            }
        }
    }
}
