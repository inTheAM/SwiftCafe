//
//  FoodDetailsView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import SwiftUI

struct FoodDetailsView: View {
    @EnvironmentObject var cart: Cart
    @ObservedObject var viewModel: FoodDetailsViewModel
    @Environment(\.presentationMode)    var presentationMode

    init(food: Food) {
        self.viewModel = FoodDetailsViewModel(food: food)
    }

    var body: some View {
        VStack(spacing: 0) {
            FoodDetailsHeaderView(viewModel: viewModel, presentationMode: presentationMode)
                .overlayDivider(.bottom)

            OptionGroupsView(viewModel: viewModel)
                .overlayDivider(.bottom)

            HStack {
                Spacer()
                Text("\(viewModel.quantity)")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal, 10)
                    .background(RoundedRectangle(cornerRadius: 10).stroke())
                Stepper("", value: $viewModel.quantity, in: 1...viewModel.stockQuantity)
                    .accessibilityIdentifier("Quantity stepper")
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .overlayDivider(.bottom)
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
                    .accessibilityIdentifier("Add to cart")
                    .disabled(cart.isModifying)
                }
                .padding()
            }
            .background(Color.green.opacity(0.2).ignoresSafeArea())
        }
    }
}
