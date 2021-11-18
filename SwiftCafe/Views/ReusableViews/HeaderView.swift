//
//  HeaderView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    
    var body: some View    {
        HStack {
            Text(title)
                .font(.title.bold())
            Spacer()
        }
        .padding()
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
