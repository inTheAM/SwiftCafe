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

    @State private var optionsExpanded = false
    @State private var extrasExpanded = false

    init(food: Food) {
        self.viewModel = FoodDetailsViewModel(food: food)
    }

    var body: some View {
        VStack(spacing: 0) {
            FoodDetailsHeaderView(viewModel: viewModel, presentationMode: presentationMode)
                .overlayDivider(.bottom)

            OptionGroupsView(viewModel: viewModel, optionsExpanded: $optionsExpanded)

            Spacer(minLength: 0)
            HStack {
                Spacer()
                Text("\(viewModel.quantity)")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal, 10)
                    .background(RoundedRectangle(cornerRadius: 10).stroke())
                    .accessibilityIdentifier("Quantity")

                Stepper("", value: $viewModel.quantity, in: 1...viewModel.stockQuantity)
                    .accessibilityIdentifier("Quantity stepper")
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .overlayDivider(.top)
            .overlayDivider(.bottom)

            FoodDetailsFooterView(viewModel: viewModel)
        }
        .onChange(of: optionsExpanded) { isExpanded in
            if isExpanded {
                extrasExpanded = false
            }
        }
        .onChange(of: extrasExpanded) { isExpanded in
            if isExpanded {
                optionsExpanded = false
            }
        }
    }
}
