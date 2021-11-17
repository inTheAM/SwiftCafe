//
//  BackButton.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

struct BackButton: View {
    @Binding var presentationMode: PresentationMode
    var body: some View {
        Button {
            $presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.title2)
                .foregroundColor(.primary)
        }
        .accessibilityIdentifier("back")
    }
}
