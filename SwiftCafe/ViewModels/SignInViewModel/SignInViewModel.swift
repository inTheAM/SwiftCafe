//
//  SignInViewModel.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
import Foundation

/// The ViewModel that handles the `SignInView` screen.
final class SignInViewModel: ObservableObject {

    /// The authentication service that handles requests for the view model.
    private let authService: AuthServiceProtocol

    /// The cancellables set that stores the publishers in this view model.
    private var cancellables = Set<AnyCancellable>()

// MARK: - Inputs

    /// The published input for the user's email address.
    @Published var email = ""

    /// The published input for the user's password.
    @Published var password = ""

// MARK: - Validation
    /// Indicates whether the email input is valid.
    @Published var isFormValid = false

// MARK: - Inline Errors
    /// An inline error displayed when sign-in fails.
    @Published var signInErrorDescription = ""

// MARK: - Initializer
    /// The initializer for the view model.
    /// - Parameter authService: An instance of a type that conforms to `AuthServiceProtocol`.
    ///                          The default value is the return of the create method defined on `AuthServiceFactory`.
    init(authService: AuthServiceProtocol = AuthService.shared) {
        self.authService = authService

        /// Initializing the form validity publisher.
        /// The publisher is received on the main thread, assigned to `isFormValid`
        /// and stored in the cancellables set.
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .map { formStatus in
                switch formStatus {
                case .valid:
                    self.signInErrorDescription = ""
                    return true
                default:
                    self.signInErrorDescription = formStatus.description
                    return false
                }
            }
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - Form Validation
extension SignInViewModel {

    /// A publisher that returns a boolean indicating
    /// whether the email input is empty or not.
    private var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
            .dropFirst()
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map {
                $0.isEmpty
            }
            .eraseToAnyPublisher()
    }

    /// A publisher that returns a boolean value indicating
    /// whether the password input is empty or not.
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

    /// A publisher that returns a boolean value indicating
    /// whether the filled form is valid or not.
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
    /// Uses the `authService` to make a sign-in request with the filled email and password details.
    /// - Parameter completion: A closure the method runs when the sign-up succeeds.
    ///                         The closure takes no parameters and returns nothing.
    /// In case of a failed sign-in, the `signInErrorDescription` is updated with the error.
    func signIn(completion: @escaping () -> Void) {
        authService.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                completion()
            case .failure:
                self.signInErrorDescription = AuthError.signInFailed.description
            }
        }
    }
}
