//
//  CartView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import SwiftUI

/// #The view that displays the contents of the user's cart and
/// #let's the user check out their cart.
struct CartView: View {

    /// The presentation mode that dismisses this view.
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {

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
