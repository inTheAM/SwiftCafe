//
//  FoodDetailsView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import SwiftUI

/// #The view that shows the details for a food and
/// #lets the user select options and extras and
/// #add the food to the user's cart.
struct FoodDetailsView: View {

    /// The cart instance in the environment.
    @EnvironmentObject var cartManager: CartManager

    /// The `FoodDetailsViewModel` instance that manages this view.
    @ObservedObject var viewModel: FoodDetailsViewModel

    /// The presentation mode that dismisses this view.
    @Environment(\.presentationMode)    var presentationMode

    /// The toggle for expanding the disclosure view containing the options for this food.
    @State private var optionsExpanded = false

    /// Initializes the view model with a food.
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

                Stepper("", value: $viewModel.quantity, in: 1...10)
                    .accessibilityIdentifier("Quantity stepper")
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .overlayDivider(.top)
            .overlayDivider(.bottom)

            FoodDetailsFooterView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.fetchOptions()
            viewModel.selectedOptions = cartManager.selectedOptions(for: viewModel.food)
            if cartManager.contains(viewModel.food) {
                optionsExpanded = true
            }
        }
    }
}
