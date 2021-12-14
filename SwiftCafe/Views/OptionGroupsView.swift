//
//  OptionGroupView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

struct OptionGroupsView: View {
    @ObservedObject var viewModel: FoodDetailsViewModel
    @State private var optionsExpanded = false
    var body: some View {
        DisclosureView(label: "Customize your order", isExpanded: $optionsExpanded) {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.options, id: \.name) { optionGroup in
                    OptionsView(viewModel: viewModel, optionGroup: optionGroup)
                }
            }
        }
    }
}

struct OptionGroupView_Previews: PreviewProvider {
    static var previews: some View {
        OptionGroupsView(viewModel: FoodDetailsViewModel(food: Food.createItems()[0]))
    }
}
