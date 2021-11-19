//
//  CartView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import SwiftUI

struct CartView: View {
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
