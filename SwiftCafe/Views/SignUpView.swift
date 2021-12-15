//
//  SignUpView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

/// The view that handles user sign-up.
struct SignUpView: View {

    /// The presentation mode used to dismiss this view.
    @Environment(\.presentationMode) var presentationMode

    /// The view model that manages this view.
    /// An instance of `SignUpViewModel`
    @StateObject var viewModel = SignUpViewModel()

    /// A binding to a boolean that indicates whether the user is signed in or not.
    /// A successful sign-up toggles the value to true.
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .opacity(0.7)

            VStack {
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(viewModel.isEmailValid ? .green.opacity(0.5) : .primary.opacity(0.3))
                    )
                    .accessibilityIdentifier("email input")

                HStack {
                    Text(viewModel.emailErrorDescription)
                        .font(.caption)
                        .foregroundColor(.red)
                    Spacer()
                }.padding(.bottom)

                if viewModel.isEmailValid {
                    VStack(spacing: 0) {
                        SecureField("Password", text: $viewModel.password)
                            .autocapitalization(.none)
                            .padding()
                            .overlayDivider(.bottom)
                            .accessibilityIdentifier("password input")

                        SecureField("Confirm password", text: $viewModel.repeatedPassword)
                            .autocapitalization(.none)
                            .padding()
                            .accessibilityIdentifier("repeat password")

                    }.background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(viewModel.isPasswordValid ? .green.opacity(0.5) : .primary.opacity(0.3))
                    )

                    HStack {
                        Text(viewModel.passwordErrorDescription)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }.padding(.bottom)

                    Spacer()

                    Button("Sign up") {
                        viewModel.signUp {
                            isLoggedIn = true
                        }
                    }.font(.body.bold())
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue.cornerRadius(20))
                        .grayscale(viewModel.isFormValid ? 0 : 1)
                        .disabled(!viewModel.isFormValid)
                        .accessibilityIdentifier("sign up")
                }
                Spacer()
            }
            .animation(.default)
            .padding(.top, 48)
            .padding()
            .navigationTitle("Sign up")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(presentationMode: presentationMode)
                }
            }
        }
    }
}
