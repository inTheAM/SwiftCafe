//
//  SignUpView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .padding()
                .accessibilityIdentifier("email")
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(viewModel.isEmailValid ? .green.opacity(0.5) : .primary.opacity(0.3))
                )
                .padding(.top, 180)
        }
    }
}

