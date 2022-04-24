//
//  MenuSectionsSelector.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

/// #The view that let's the user select the section to view.
struct MenuSectionsSelector: View {

    /// The `MenuViewModel` instance that manages this view.
    @ObservedObject var viewModel: MenuViewModel

    /// A namespace for matching the geometry effect of the selector between sections.
    @Namespace var namespace
    

    var body: some View {
                        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    ForEach(viewModel.sections, id: \.name) {    section    in
                        Button(action: {
                            withAnimation { viewModel.activeSection    =    section.name }
                            
                        }, label: {
                            VStack {
                                Text(section.name)
                                    .font(viewModel.activeSection    ==    section.name    ?    .headline    :    .body)
                                    .bold()
                                    .foregroundColor(
                                        viewModel.activeSection == section.name ? .primary : .secondary.opacity(0.6))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .id(section.name)
                                if viewModel.activeSection == section.name {
                                    RoundedRectangle(cornerRadius: 3)
                                        .frame(height: 3)
                                        .foregroundColor(.primary)
                                        .matchedGeometryEffect(id: "SectionUnderline", in: namespace)
                                        .drawingGroup()
                                } else {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 3)
                                        .foregroundColor(.clear)
                                        .padding(.horizontal, 6)
                                        .drawingGroup()
                                }
                            }
                        }).accessibilityIdentifier(section.name)
                    }
                }
                .padding(.horizontal)
                .onChange(of: viewModel.activeSection) { section in
                    withAnimation { proxy.scrollTo(section, anchor: UnitPoint(x: 0.4, y: 0)) }
                }
            }
            .padding(.vertical, 10)
            .background(
                ZStack {
                    Color.systemBackground
                    Color.white.opacity(0.2)
                }
            )
        }
    }
}
