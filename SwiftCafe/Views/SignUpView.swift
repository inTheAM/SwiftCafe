//
//  SignUpView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = SignUpViewModel()
    @Binding var isLoggedIn: Bool
    var body: some View {
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
                        .overlayDivider()
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
                    viewModel.signUp() {
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
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton(presentationMode: presentationMode)
            }
        }
    }
}

