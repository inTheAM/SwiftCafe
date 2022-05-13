//
//  OptionsView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

/// #A view that shows a list of options in which the user can only select one.
struct OptionsView: View {

    @EnvironmentObject var cartManager: CartManager
    
    /// The view model that manages the food details view.
    @ObservedObject var viewModel: FoodDetailsViewModel

    /// The option group to display.
    let optionGroup: OptionGroup

    /// The selected option in this option group.
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
                        viewModel.removeOption(optionGroup)
                        selectedOption = nil
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(.caption.bold())
                    .foregroundColor(.red)
                }
            }
            Divider()
                .padding(.horizontal, -10)

            if cartManager.contains(viewModel.food) {
                if let option = viewModel.selectedOptions.first(where: { $0.optionGroupID == optionGroup.id } ) {
                    HStack {
                        Text(option.name)
                            .font(.caption.bold())
                        
                        Spacer()
                        
                        Text("+ $\(option.priceDifference.format(2))")
                            .font(.caption.bold())
                        
                        CheckBox(isSelected: true)
                    }
                }
            } else {
                ForEach(optionGroup.options) { option in
                    Button {
                        selectedOption = option
                        viewModel.selectOption(option)
                    } label: {
                        HStack {
                            Text(option.name)
                                .font(.caption.bold())
                            
                            Spacer()
                            
                            Text("+ $\(option.priceDifference.format(2))")
                                .font(.caption.bold())
                            
                            CheckBox(isSelected: selectedOption == option)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityIdentifier("\(optionGroup.name) \(option.name)")
                    .onAppear {
                        if viewModel.selectedOptions.contains(where: { $0.name == option.name} ) {
                            selectedOption = option
                        }
                    }
                }
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
