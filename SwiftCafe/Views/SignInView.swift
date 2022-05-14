//
//  SignInView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

/// #The view that handles user sign-up.
struct SignInView: View {

    /// The view model that manages this view.
    /// An instance of `SignInViewModel`
    @StateObject var viewModel = SignInViewModel()

    /// A binding to a boolean that indicates whether the user is signed in or not.
    /// A successful sign-in toggles the value to true.
    @Binding var isSignedIn: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .opacity(0.7)

                VStack {
                    VStack(spacing: 30) {
                        Text("SwiftCafe")

                        Image(systemName: "mappin.and.ellipse")
                            .accessibilityIdentifier("logo")
                    }
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding(48)

                    TextField("Email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.primary.opacity(0.3))
                        )
                        .padding(.bottom)
                        .accessibilityIdentifier("sign-in-email-input")

                    SecureField("Password", text: $viewModel.password)
                        .autocapitalization(.none)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.primary.opacity(0.3))
                        )
                        .accessibilityIdentifier("sign-in-password-input")

                    HStack {
                        Text(viewModel.signInErrorDescription)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }.padding(.bottom)

                    HStack {
                        NavigationLink("Don't have an account?", destination: SignUpView(isSignedIn: $isSignedIn))
                            .font(.subheadline.bold())
                            .accessibilityIdentifier("go-to-signup")
                        Spacer()
                    }.padding(.bottom)

                    Spacer()

                    Button("Sign in") {
                        viewModel.signIn {
                            isSignedIn = true
                        }
                    }.font(.body.bold())
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue.cornerRadius(20))
                        .grayscale(viewModel.isFormValid ? 0 : 1)
                        .disabled(!viewModel.isFormValid)
                        .accessibilityIdentifier("sign-in")

                    Spacer()
                }
                .animation(.default)
                .padding(.horizontal)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}
