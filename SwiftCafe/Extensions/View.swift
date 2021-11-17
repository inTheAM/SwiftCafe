//
//  View.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

extension View    {    
    func overlayDivider()    ->    some View    {
        return self.overlay(Divider(),    alignment: .bottom)
    }
    
    func readOffset(_ offsetHandler: @escaping (_ rect: CGRect) -> ()) -> some View {
        GeometryReader { geometry in
            self
                .preference(key: OffsetKey.self, value: geometry.frame(in: .named("ScrollView")))
        }
        .onPreferenceChange(OffsetKey.self) { rect in
            offsetHandler(rect)
        }
    }
}
