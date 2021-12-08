//
//  OptionsView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

struct OptionsView: View {
    @ObservedObject var viewModel: FoodDetailsViewModel
    let optionGroup: OptionGroup
    @State private var selection: Option?
    @Namespace var namespace

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(optionGroup.name)
                    .bold()
                Spacer()
                if selection != nil {
                    Button("Clear") {
                        viewModel.removeOption(selection)
                        selection = nil
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(.subheadline.bold())
                    .foregroundColor(.red)
                }
            }
            Divider()
                .padding(.horizontal, -10)
            ForEach(optionGroup.options) { option in
                Button {
                    selection = option
                    viewModel.selectOption(option)
                } label: {
                    HStack {
                        Text(option.name)
                        Spacer()
                        CheckBox(isSelected: selection == option, namespace: namespace)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .animation(.default)
            }
        }
        .padding(10)
        .cardify()
        .padding()
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(viewModel: FoodDetailsViewModel(food: Food.createItems()[0]), optionGroup: OptionGroup.samples[0])
    }
}
