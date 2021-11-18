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

// swiftlint:disable line_length
    private let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[S@$#!%*?&]).{8,}$")
// swiftlint:enable line_length
    
// MARK: - Inputs
    @Published var email = ""
    @Published var password = ""
    @Published var repeatedPassword = ""

// MARK: - Validation
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var isFormValid = false

// MARK: - Inline Errors
    @Published var emailErrorDescription = ""
    @Published var passwordErrorDescription = ""
    @Published var signUpErrorDescription = ""

// MARK: - Initializer
    init(authService: AuthServiceProtocol = AuthServiceFactory.create()) {
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

        isPasswordInputValidPublisher
            .receive(on: RunLoop.main)
            .map { status in
                switch status {
                case .valid:
                    self.passwordErrorDescription = ""
                    return true
                default:
                    self.passwordErrorDescription = status.rawValue
                    return false
                }
            }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellables)

        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - Email Validation
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

// MARK: - Password Validation
enum PasswordStatus: String {
    case empty = "Password cannot be empty",
         short = "Password is too short. Use 8 characters or more",
         weak = "Password must contain at least one number and one special character",
         passwordsDoNotMatch = "Passwords do not match",
         valid = ""
}

extension SignUpViewModel {
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                password.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var isPasswordShortPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                password.count < 8
            }
            .eraseToAnyPublisher()
    }

    private var isPasswordStrongPublisher: AnyPublisher<Bool, Never> {
        $password
            .dropFirst()
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { password in
                self.passwordPredicate.evaluate(with: password)
            }
            .eraseToAnyPublisher()
    }

    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $repeatedPassword)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { password, repeatedPassword in
                password == repeatedPassword
            }
            .eraseToAnyPublisher()
    }

    private var isPasswordInputValidPublisher: AnyPublisher<PasswordStatus, Never> {
        Publishers.CombineLatest4(isPasswordEmptyPublisher,
                                  isPasswordShortPublisher,
                                  isPasswordStrongPublisher,
                                  arePasswordsEqualPublisher)
            .map { isEmpty, isShort, isStrong, areEqual in
                if isEmpty {
                    return .empty
                }
                if isShort {
                    return .short
                }
                if !isStrong {
                    return .weak
                }
                if !areEqual {
                    return .passwordsDoNotMatch
                }
                return .valid
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Form Validation
extension SignUpViewModel {
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isEmailInputValidPublisher, isPasswordInputValidPublisher)
            .map { emailStatus, passwordStatus in
                return emailStatus == .valid && passwordStatus == .valid
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Sign Up
extension SignUpViewModel {
    func signUp(completion: @escaping () -> Void) {
        authService.signUp(email: email, password: password) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                self.signUpErrorDescription = AuthError.signUpFailed.rawValue
            }
        }
    }
}
