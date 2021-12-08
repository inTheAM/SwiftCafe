//
//  CheckBox.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

struct CheckBox: View {
    var isSelected: Bool
    var namespace: Namespace.ID
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3)

            if isSelected {
                Circle()
                    .padding(5)
                    .matchedGeometryEffect(id: "checkbox", in: namespace)
            }
        }
        .frame(width: 20, height: 20)
    }
}

struct CheckBox_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CheckBox(isSelected: true, namespace: namespace)
    }
}
