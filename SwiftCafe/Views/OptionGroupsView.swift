//
//  OptionGroupView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

/// #A disclosure view that displays the option groups for this food.
struct OptionGroupsView: View {

    @EnvironmentObject var cartManager: CartManager
    /// The view model that manages the food details view.
    @ObservedObject var viewModel: FoodDetailsViewModel

    /// A binding to a boolean value that represents the expansion state of the disclosure view
    @Binding var optionsExpanded: Bool

    private var label: String {
        cartManager.contains(viewModel.food) ? "Selected options" : "Customize your order"
    }
    var body: some View {
        DisclosureView(label: label, isExpanded: $optionsExpanded) {
            ScrollView {
                ForEach(viewModel.optionGroups, id: \.name) { optionGroup in
                    OptionsView(viewModel: viewModel, optionGroup: optionGroup)
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
            }
        }
    }
}

struct OptionGroupView_Previews: PreviewProvider {
    static var previews: some View {
        OptionGroupsView(viewModel: FoodDetailsViewModel(food: Food.createItems()[0]), optionsExpanded: .constant(true))
    }
}
