//
//  CartButton.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import SwiftUI

/// The button that toggles the presentation state of the user's cart view.
struct CartButton: View {

    /// The presentation state of the user's cart view.
    @State private var showCart = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showCart = true
                }, label: {
                    HStack {
                        Image(systemName: "bag.fill")
                            .font(.title)

                    }
                    .foregroundColor(.systemBackground)
                    .padding()
                    .frame(width: 60, height: 60)
                    .background(
                        Color.primary
                            .clipShape(Circle())
                    )
                })
                .accessibilityIdentifier("Cart")
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showCart) {
            CartView()
        }
    }
}
