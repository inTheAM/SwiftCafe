//
//  CartView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import SwiftUI

/// #The view that displays the cartContents of the user's cart and
/// #let's the user check out their cart.
struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    /// The presentation mode that dismisses this view.
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {

            }
            .onAppear {
                cartManager.fetchContents()
            }
            .navigationTitle("Your bag")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DoneButton(presentationMode: presentationMode)
                }
            }
        }
    }
}
