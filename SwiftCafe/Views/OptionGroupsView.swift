//
//  OptionGroupView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

struct OptionGroupsView: View {
    @ObservedObject var viewModel: FoodDetailsViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Customize your order")
                .bold()
                .padding(.horizontal)
                .padding(.vertical, 8)
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
