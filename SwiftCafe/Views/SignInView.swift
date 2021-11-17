//
//  SignInView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
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
                    .accessibilityIdentifier("email input")
                
                SecureField("Password", text: $viewModel.password)
                    .autocapitalization(.none)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.primary.opacity(0.3))
                    )
                    .accessibilityIdentifier("password input")
                
                HStack {
                    Text(viewModel.signInErrorDescription)
                        .font(.caption)
                        .foregroundColor(.red)
                    Spacer()
                }.padding(.bottom)
                
                HStack {
                    NavigationLink("Don't have an account?", destination: SignUpView(isLoggedIn: $isLoggedIn))
                        .font(.caption)
                        .accessibilityIdentifier("go to signup")
                    Spacer()
                }.padding(.bottom)
                
                Spacer()
                
                Button("Sign in") {
                    viewModel.signIn() {
                        isLoggedIn = true
                    }
                }.font(.body.bold())
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue.cornerRadius(20))
                    .grayscale(viewModel.isFormValid ? 0 : 1)
                    .disabled(!viewModel.isFormValid)
                    .accessibilityIdentifier("sign in")
                
                Spacer()
            }
            .animation(.default)
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
        }
    }
}

