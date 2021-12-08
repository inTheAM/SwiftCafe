//
//  FoodDetailsHeaderView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 08/12/2021.
//

import SwiftUI

struct FoodDetailsHeaderView: View {
    @ObservedObject var viewModel: FoodDetailsViewModel
    @Binding var presentationMode: PresentationMode
    var body: some View {
        HStack(alignment: .top) {
            ImageAsync(imageURL: viewModel.imageURL)
                .frame(width: 160, height: 160)
                .accessibility(addTraits: .isImage)
                .accessibilityIdentifier("\(viewModel.name) photo")
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.name)
                            .bold()
                            .accessibilityIdentifier("\(viewModel.name) name header")

                        Text(viewModel.details)
                            .font(.caption)
                            .accessibilityIdentifier("\(viewModel.details) details header")
                    }

                    Spacer()

                    CloseButton(presentationMode: $presentationMode)
                }
                .padding(.top, 5)

                Spacer()
                HStack {
                    Spacer()
                    Text(viewModel.price)
                        .bold()
                        .foregroundColor(.primary)
                }
                .padding()
            }
        }
        .frame(height: 160)
        .accessibility(addTraits: .isHeader)
        .background(
            Color(UIColor.systemBackground)
        )
    }
}
