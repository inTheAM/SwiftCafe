//
//  SignInViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
import Foundation

final class SignInViewModel: ObservableObject {
    private let authService: AuthServiceProtocol
    
    
//    MARK: - Initializer
    init(authService: AuthServiceProtocol = AuthService.shared) {
        self.authService = authService
    }
}
