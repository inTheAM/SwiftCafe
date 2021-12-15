//
//  DisclosureView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 14/12/2021.
//

import SwiftUI

/// #A view that shows a disclosure group with a label and content.
struct DisclosureView<Content>: View where Content: View {
    /// The label for the disclosure group.
    let label: String

    /// A binding to the expansion state of the disclosure view.
    @Binding var isExpanded: Bool

    /// The content displayed when the disclosure view is expanded.
    let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                isExpanded.toggle()
            } label: {
                HStack {
                    Text(label)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .renderingMode(.original)
                        .rotationEffect(.init(degrees: isExpanded ? 90 : 0))
                }
                .padding()
                .font(.subheadline.bold())
                .foregroundColor(.primary)
            }
            .accessibilityIdentifier("Expand button")

            if isExpanded {
                content()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.default)
    }
}

struct DisclosureView_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureView(label: "Label", isExpanded: .constant(true)) {
            Text("Expanded")
        }
    }
}
