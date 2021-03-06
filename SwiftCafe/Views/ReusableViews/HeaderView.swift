//
//  HeaderView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import SwiftUI

/// #A view that shows a text in a large font with a solid background.
struct HeaderView: View {

    /// The title of the view.
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title3.bold())
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .overlayDivider(.top)
        .overlayDivider(.bottom)
        .background(
            ZStack {
                Color.systemBackground
                Color.white.opacity(0.1)
            }
        )
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Header")
    }
}
