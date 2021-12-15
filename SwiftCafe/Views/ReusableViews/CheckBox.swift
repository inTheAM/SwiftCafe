//
//  CheckBox.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

struct CheckBox: View {
    var isSelected: Bool
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2)

            if isSelected {
                Circle()
                    .padding(4)
            }
        }
        .frame(width: 20, height: 20)
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(isSelected: true)
    }
}
