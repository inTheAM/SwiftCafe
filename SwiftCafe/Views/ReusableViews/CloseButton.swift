//
//  CloseButton.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 04/12/2021.
//

import SwiftUI

struct CloseButton: View {
    @Binding var presentationMode: PresentationMode
    var body: some View {
        Button {
                withAnimation {
                    $presentationMode.wrappedValue.dismiss()
                }
        } label: {
        Image(systemName: "xmark")
            .font(.headline)
            .foregroundColor(.primary)
            .padding(5)
            .background(
                Circle()
                    .foregroundColor(Color.primary.opacity(0.2))
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundColor(.primary)
                    )
            )
            .padding(10)
        }
        .accessibilityIdentifier("Close")
    }
}
