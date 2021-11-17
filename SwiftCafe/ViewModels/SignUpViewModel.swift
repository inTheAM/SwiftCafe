//
//  SignUpViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
import Foundation

final class SignUpViewModel: ObservableObject {
    private let authService: AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
//    MARK: - Inputs
    @Published var email = ""
    
    
//    MARK: - Validation
    @Published var isEmailValid = false
    
//    MARK: - Inline Errors
    @Published var emailErrorDescription = ""
    
//    MARK: - Initializer
    init(authService: AuthServiceProtocol = AuthService.shared) {
        self.authService = authService
        
        isEmailInputValidPublisher
            .receive(on: RunLoop.main)
            .map { status in
                print(status)
                switch status {
                case .valid:
                    self.emailErrorDescription = ""
                    return true
                default:
                    self.emailErrorDescription = status.rawValue
                    return false
                }
            }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)
    }
}

//  MARK: - Email Validation
enum EmailStatus: String {
    case empty = "Email cannot be empty",
         invalid = "Use a valid email address",
         unavailable = "This email address is already in use.",
         valid = ""
}
extension SignUpViewModel {
    private var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
            .dropFirst()
            .debounce(for: 1, scheduler: RunLoop.main)
            .map {
                $0.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    private var isEmailAvailablePublisher: AnyPublisher<Bool, Never> {
        $email
            .dropFirst()
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .flatMap { email in
                return Future { promise in
                    self.authService.checkEmailAvailability(email: email) { isAvailable in
                        return promise(.success(isAvailable))
                    }
                }
            }.eraseToAnyPublisher()
    }
    
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .dropFirst()
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { email in
                email.count > 9 && email.contains("@") && email.contains(".com")
            }
            .eraseToAnyPublisher()
    }
    
    private var isEmailInputValidPublisher: AnyPublisher<EmailStatus, Never> {
        Publishers.CombineLatest3(isEmailEmptyPublisher, isEmailAvailablePublisher, isEmailValidPublisher)
            .map { isEmpty, isAvailable, isValid in
                if isEmpty {
                    return .empty
                }
                if !isValid {
                    return .invalid
                }
                if !isAvailable {
                    return .unavailable
                }
                return .valid
            }
            .eraseToAnyPublisher()
    }
}
