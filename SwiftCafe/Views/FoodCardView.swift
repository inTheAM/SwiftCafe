//
//  FoodCardView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import SwiftUI

struct FoodCardView: View {
    let food: Food
    @State private var showDetails    =    false
    var body: some View {
        Button(action: {
            showDetails    =    true
        }, label: {
            HStack(alignment: .top, spacing: 0) {
                ImageAsync(imageURL: food.imageURL)

                VStack(alignment: .leading) {
                    Text(food.name)
                        .font(.caption)
                        .bold()

                    Text(food.details)
                        .font(.caption2)

                    Spacer(minLength: 0)
                    HStack {
                        Spacer()

                        Text("$\(food.price)")
                            .font(.body.bold())
                            .foregroundColor(.primary)

                    }

                }.padding(10)
            }
            .frame(height: 120)
            .cardify()
            .padding(.vertical, 5)
            .fullScreenCover(isPresented: $showDetails) {
                FoodDetailsView(food: food)
            }
        })
        .accessibilityIdentifier(food.name)
        .buttonStyle(PlainButtonStyle())
    }
}
