//
//  MenuView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

struct MenuView: View {
    @StateObject var viewModel = MenuViewModel()

    var body: some View {
        NavigationView {
            ZStack {
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
                                    }
                                    .id(section.name)
                                    .readOffset { rect in
                                        activateSection(section, in: rect)
                                    }
                                }
                            }
                            .padding(.bottom, 76)
                            .onAppear {
                                viewModel.fetchMenu()
                            }
                        }
                    }
                }
                CartButton()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LocationButton()
                }
            }
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
