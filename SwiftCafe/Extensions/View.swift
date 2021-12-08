//
//  View.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

extension View {
    func overlayDivider(_ alignment: Alignment)    ->    some View {
        return self.overlay(Divider(), alignment: alignment)
    }

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

    func cardify()    ->    some View {
        return self
            .background(Color(UIColor.systemBackground).overlay(Color.white.opacity(0.2)))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.5), radius: 3)
    }
}
