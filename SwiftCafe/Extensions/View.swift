//
//  View.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

extension View {

    /// Overlays a Divider onto the view
    /// - Parameter alignment: The alignment to use when overlaying the divider
    /// - Returns: A new view with the divider overlaid.
    func overlayDivider(_ alignment: Alignment)    ->    some View {
        return self.overlay(Divider(), alignment: alignment)
    }

    /// Overlays a GeoemtryReader onto the view to read the offset of the view
    /// when the user scrolls or swipes.
    /// - Parameter offsetHandler: A closure that takes a CGRect and returns nothing.
    /// - Returns: A new view with the GeometryReader overlaid.
    func readOffset(_ offsetHandler: @escaping (_ rect: CGRect) -> Void) -> some View {
        return self
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: OffsetKey.self, value: geometry.frame(in: .named("ScrollView")))
                }
            )
            .onPreferenceChange(OffsetKey.self) { rect in
                offsetHandler(rect)
            }
    }

    /// Adds a card-like background to a view.
    /// - Returns: A new view with the background set.
    func cardify()    ->    some View {
        return self
            .background(Color(UIColor.systemBackground).overlay(Color.white.opacity(0.2)))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.5), radius: 3)
    }
}
