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
    private var cancellables = Set<AnyCancellable>()

// MARK: - Inputs
    @Published var email = ""
    @Published var password = ""

// MARK: - Validation
    @Published var isFormValid = false

// MARK: - Inline Errors
    @Published var signInErrorDescription = ""

// MARK: - Initializer
    init(authService: AuthServiceProtocol = AuthService.shared) {
        self.authService = authService

        isFormValidPublisher
            .receive(on: RunLoop.main)
            .map { formStatus in
                switch formStatus {
                case .valid:
                    self.signInErrorDescription = ""
                    return true
                default:
                    self.signInErrorDescription = formStatus.rawValue
                    return false
                }
            }
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - Form Validation
enum FormStatus: String {
    case emailEmpty = "Input your email address",
         passwordEmpty = "Enter your password",
         valid = ""
}

extension SignInViewModel {
    private var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
            .dropFirst()
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map {
                $0.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .dropFirst()
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                password.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var isFormValidPublisher: AnyPublisher<FormStatus, Never> {
        Publishers.CombineLatest(isEmailEmptyPublisher, isPasswordEmptyPublisher)
            .map { emailEmpty, passwordEmpty in
                if emailEmpty {
                    return .emailEmpty
                }
                if passwordEmpty {
                    return .passwordEmpty
                }
                return .valid
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Sign In
extension SignInViewModel {
    func signIn(completion: @escaping () -> Void) {
        authService.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                self.signInErrorDescription = AuthError.signInFailed.rawValue
            }
        }
    }
}
