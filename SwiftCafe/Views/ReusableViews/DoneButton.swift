//
//  DoneButton.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import SwiftUI

struct DoneButton: View {
    @Binding var presentationMode: PresentationMode

    var body: some View {
        Button("Done") {
            $presentationMode.wrappedValue.dismiss()
        }
        .font(.headline)
        .foregroundColor(.blue)
        .accessibilityIdentifier("Done")
    }
}
