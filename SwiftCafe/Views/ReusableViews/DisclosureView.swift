//
//  DisclosureView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 14/12/2021.
//

import SwiftUI

struct DisclosureView<Content: View>: View {
//    The label for the disclosure group
    let label: String
    
//    A Binding to the expansion state of the disclosure group
    @Binding var isExpanded: Bool
    
//    The content displayed when the disclosure group is expanded
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
                .padding(.vertical, 8)
                .font(.subheadline.bold())
                .foregroundColor(.primary)
            }
            if isExpanded {
                content()
            }
        }
        .padding(.horizontal)
        .animation(.spring())
    }
}

struct DisclosureView_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureView(label: "Label", isExpanded: .constant(true)) {
            Text("Expanded")
        }
    }
}
