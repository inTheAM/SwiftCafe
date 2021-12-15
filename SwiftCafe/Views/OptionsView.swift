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
    @State private var selectedOption: Option?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(optionGroup.name)
                    .font(.subheadline.bold())
                    .accessibilityIdentifier(optionGroup.name)

                Spacer()

                if selectedOption != nil {
                    Button("Clear") {
                        viewModel.removeOption(selectedOption)
                        selectedOption = nil
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
                    selectedOption = option
                    viewModel.selectOption(option)
                } label: {
                    HStack {
                        Text(option.name)
                            .font(.caption.bold())

                        Spacer()

                        CheckBox(isSelected: selectedOption == option)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityIdentifier("\(optionGroup.name) \(option.name)")
            }
        }
        .padding(10)
        .cardify()
        .animation(.default)
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(viewModel: FoodDetailsViewModel(food: Food.createItems()[0]), optionGroup: OptionGroup.samples[0])
    }
}
