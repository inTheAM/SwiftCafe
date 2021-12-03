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
        VStack {
            HStack(alignment: .top) {
                ImageAsync(imageURL: viewModel.imageURL)
                    .frame(width: 80, height: 80)
                    .accessibility(addTraits: .isImage)
                    .accessibilityIdentifier("\(viewModel.name) photo")

                VStack(alignment: .leading) {
                    Text(viewModel.name)
                        .bold()
                        .accessibilityIdentifier("\(viewModel.name) name header")

                    Text(viewModel.details)
                        .font(.caption)
                        .accessibilityIdentifier("\(viewModel.details) details header")
                }
                .padding(.top, 5)

                Spacer()

                CloseButton(presentationMode: presentationMode)
            }
            .accessibility(addTraits: .isHeader)
            .background(
                Color(UIColor.systemBackground)
            )
            .overlayDivider(.bottom)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()

                    HStack {
                        Spacer()
                        Text(viewModel.price)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .overlayDivider(.bottom)

                }
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
                .padding()
                .overlayDivider(.bottom)
            }
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
                        .foregroundColor(cart.contains(viewModel.food) ? Color.white : Color(UIColor.systemBackground))
                        .buttonStyle(PlainButtonStyle())
                        .padding(10)
                        .background(cart.contains(viewModel.food) ? Color.red : Color.primary)
                        .cornerRadius(20)
                }
                .accessibilityIdentifier("Add to cart")
                .disabled(cart.isModifying)
            }.padding()

        }
    }
}

