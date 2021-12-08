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

            FoodDetailsFooterView(viewModel: viewModel)
        }
    }
}
