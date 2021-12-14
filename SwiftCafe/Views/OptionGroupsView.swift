//
//  OptionGroupView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

struct OptionGroupsView: View {
    @ObservedObject var viewModel: FoodDetailsViewModel
    @Binding var optionsExpanded: Bool
    var body: some View {
        DisclosureView(label: "Customize your order", isExpanded: $optionsExpanded) {
            ScrollView {
                ForEach(viewModel.options, id: \.name) { optionGroup in
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
