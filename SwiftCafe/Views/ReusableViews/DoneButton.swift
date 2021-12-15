//
//  DoneButton.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import SwiftUI

/// #A button that dismisses the current view.
/// ##Takes the appearance of the system `Done` button.
struct DoneButton: View {

    /// A binding for the presentation mode of the view to be dismissed.
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
