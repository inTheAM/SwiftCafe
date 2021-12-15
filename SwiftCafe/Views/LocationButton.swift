//
//  LocationButton.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import SwiftUI

/// #The button that toggles the presentation state of the location selection view.
struct LocationButton: View {

    /// The presentation state of the location selection view.
    @State private var showLocation = false

    /// The scale of the location icon.
    /// Used to animate the location icon to scale up and down.
    @State private var scale: CGFloat = 0.2

    var body: some View {
        Button {
            showLocation = true
        } label: {
            HStack {
                Image(systemName: "location.fill")
                    .font(.subheadline)
                    .scaleEffect(scale)
                    .animation(.spring().repeatForever(), value: scale)
                Text("Location here")

            }.font(.subheadline.bold())
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 5)
        .foregroundColor(.primary)
        .accessibilityIdentifier("Location")
        .onAppear {
            scale = 1
        }
        .fullScreenCover(isPresented: $showLocation) {

        }
    }
}

struct LocationButton_Previews: PreviewProvider {
    static var previews: some View {
        LocationButton()
    }
}
