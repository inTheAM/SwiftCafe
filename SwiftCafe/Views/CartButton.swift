//
//  CartButton.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 19/11/2021.
//

import SwiftUI

struct CartButton: View {
    @State private var showCart = false
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {showCart = true})    {
                    HStack {
                        Image(systemName: "bag.fill")
                            .font(.title)
                        
                    }
                    .foregroundColor(Color.systemBackground)
                    .padding()
                    .frame(width: 60, height: 60)
                    .background(
                        Color.primary
                            .clipShape(Circle())
                    )
                }
            }.padding()
        }
        .fullScreenCover(isPresented: $showCart) {
            
        }
    }
}
