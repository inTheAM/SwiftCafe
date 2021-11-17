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
        VStack(spacing: 30) {
            Text("SwiftCafe")
            
            Image(systemName: "mappin.and.ellipse")
                .accessibilityIdentifier("logo")
        }
        .font(.system(size: 40, weight: .bold, design: .rounded))
        .padding(48)
        
        
    }
}

