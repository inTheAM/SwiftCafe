//
//  MenuView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

struct MenuView: View {
    @StateObject var viewModel = MenuViewModel()
    @State private var isFlashing = false

    var body: some View {
        ScrollViewReader { pageProxy in
            VStack(spacing: 0) {
                MenuSectionsSelector(viewModel: viewModel, pageProxy: pageProxy)
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        ForEach(viewModel.sections) { section in
                            Section(header: HeaderView(title: section.name)) {
                                VStack {
                                    ForEach(section.items) { food in
                                        FoodCardView(food: food)
                                    }
                                }
                                .padding()
                                .overlay(flash(section.name))

                            }
                            .id(section.name)
                            .overlayDivider()
                            .readOffset { rect in
                                activateSection(section, in: rect)
                            }
                        }

                    }
                    .onAppear {
                        viewModel.fetchMenu()
                    }
                }

            }
        }
    }

    @ViewBuilder private func flash (_ section: String) -> some View {
        if isFlashing && section == viewModel.activeSection {
            Color.primary.opacity(0.1)
        }
    }

    private func activateSection(_ section: MenuSection, in rect: CGRect) {
        if rect.minY < 360 && rect.maxY > 520 && section.name != viewModel.activeSection {
            viewModel.activeSection = section.name
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
