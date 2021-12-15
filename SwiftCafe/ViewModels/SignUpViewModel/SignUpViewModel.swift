//
//  SignUpViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
import Foundation

/// #The ViewModel that handles the `SignUpView` screen.
final class SignUpViewModel: ObservableObject {

    /// The authentication service that handles requests for the view model.
    private let authService: AuthServiceProtocol

    /// The cancellables set that stores the publishers in this view model.
    private var cancellables = Set<AnyCancellable>()

// swiftlint:disable line_length
    /// The predicate that a password must pass to be considered strong.
    /// A strong password contains at least 8 characters, a number and a special character.
    private let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[S@$#!%*?&]).{8,}$")
// swiftlint:enable line_length

// MARK: - Inputs

    /// The published input for the user's email address.
    @Published var email = ""

    /// The published inputs for the user's password and a repeated password.
    /// The two passwords must match.
    @Published var password = ""
    @Published var repeatedPassword = ""

// MARK: - Validation
    /// Indicates whether the email input is valid.
    @Published var isEmailValid = false

    /// Indicates whether the password input is valid.
    @Published var isPasswordValid = false

    /// Indicates whether the form has been filled correctly.
    @Published var isFormValid = false

// MARK: - Inline Errors
    /// An inline error displayed when the email input fails validation.
    @Published var emailErrorDescription = ""

    /// An inline error displayed when the password input fails validation.
    @Published var passwordErrorDescription = ""

    /// An inline error displayed when sign-up fails.
    @Published var signUpErrorDescription = ""

    // MARK: - Initializer
    /// The initializer for the view model.
    /// - Parameter authService: An instance of a type that conforms to `AuthServiceProtocol`.
    ///                          The default value is the return of the create method defined on `AuthServiceFactory`.
    init(authService: AuthServiceProtocol = AuthServiceFactory.create()) {
        self.authService = authService

        /// Initializing the email validity publisher and storing it in the cancellables set.
        /// The publisher is received on the main thread, assigned to `isEmailValid`
        /// and stored in the cancellables set.
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

        /// Initializing the password validity publisher.
        /// The publisher is received on the main thread, assigned to `isPasswordValid`
        /// and stored in the cancellables set.
        isPasswordInputValidPublisher
            .receive(on: RunLoop.main)
            .map { status in
                switch status {
                case .valid:
                    self.passwordErrorDescription = ""
                    return true
                default:
                    self.passwordErrorDescription = status.inlineError
                    return false
                }
            }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellables)

        /// Initializing the form validity publisher.
        /// The publisher is received on the main thread, assigned to `isFormValid`
        /// and stored in the `cancellables` set.
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - Email Validation
extension SignUpViewModel {
    /// A publisher that returns a boolean indicating
    /// whether the email input is empty or not.
    private var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
            .dropFirst()
            .debounce(for: 1, scheduler: RunLoop.main)
            .map {
                $0.isEmpty
            }
            .eraseToAnyPublisher()
    }

    /// A publisher that returns a boolean value indicating
    /// whether the email address is available for account creation or not.
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

    /// A publisher that returns a boolean value indicating
    /// whether the email address is a valid address or not.
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

    /// A publisher that combines `isEmailAvailablePublisher`, `isEmailAvailablePublisher` and `isEmailValidPublisher`.
    /// Returns an EmailStatus describing the current state of the email input.
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
extension SignUpViewModel {
    /// A publisher that returns a boolean value indicating
    /// whether the password input is empty or not.
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                password.isEmpty
            }
            .eraseToAnyPublisher()
    }

    /// A publisher that returns a boolean value indicating
    /// whether the password is short or not.
    private var isPasswordShortPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                password.count < 8
            }
            .eraseToAnyPublisher()
    }

    /// A publisher that returns a boolean value indicating
    /// whether the password is strong or not.
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

    /// A publisher that returns a boolean value indicating
    /// whether the two password inputs are equal or not.
    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $repeatedPassword)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { password, repeatedPassword in
                password == repeatedPassword
            }
            .eraseToAnyPublisher()
    }

    /// A publisher that combines `isPasswordEmptyPublisher`, `isPasswordShortPublisher`,
    /// `isPasswordStrongPublisher` and `arePasswordsEqualPublisher`
    /// and returns a PasswordStatus describing the current state of the password input
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
    /// A publisher that returns a boolean value indicating
    /// whether the filled form is valid or not.
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
    /// Uses the `authService` to make a sign-up request with the filled email and password details.
    /// - Parameter completion: A closure the method runs when the sign-up succeeds.
    ///                         The closure takes no parameters and returns nothing.
    /// In case of a failed sign-up, the `signUpErrorDescription` is updated with the error.
    func signUp(completion: @escaping () -> Void) {
        authService.signUp(email: email, password: password) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                self.signUpErrorDescription = AuthError.signUpFailed.description
            }
        }
    }
}
