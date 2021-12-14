//
//  FoodDetailsFooterView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

struct FoodDetailsFooterView: View {
    @ObservedObject var viewModel: FoodDetailsViewModel
    @EnvironmentObject var cart: Cart
    var body: some View {
        VStack {
            HStack {
                Text("Summary: \(viewModel.selectionSummary)")
                    .bold()
                    .foregroundColor(.primary)

                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .overlayDivider(.bottom)

            HStack {
                Text("Total: \(viewModel.totalPrice)")
                    .bold()
                    .accessibilityIdentifier("Total price")

                Spacer()

                Button {
                    cart.contains(viewModel.food)  ?
                    cart.remove(viewModel.food) :
                    cart.add(viewModel.food, quantity: viewModel.quantity)

                } label: {
                    Text(cart.contains(viewModel.food) ?   "Remove from bag"  : "Add to bag")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(
                            cart.contains(viewModel.food) ?
                            Color.white :
                                Color(UIColor.systemBackground)
                        )
                        .buttonStyle(PlainButtonStyle())
                        .padding(10)
                        .background(cart.contains(viewModel.food) ? Color.red : Color.primary)
                        .cornerRadius(20)
                }
                .accessibilityIdentifier("Add to bag")
                .disabled(cart.isModifying)
            }
            .padding()
        }
//        .background(Color.blue.opacity(0.2).ignoresSafeArea())
    }
}

struct FoodDetailsFooterView_Previews: PreviewProvider {
    @ObservedObject static var cart = Cart()
    static var previews: some View {
        FoodDetailsFooterView(viewModel: FoodDetailsViewModel(food: Food.createItems()[0]))
            .environmentObject(cart)
    }
}
