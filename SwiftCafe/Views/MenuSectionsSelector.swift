//
//  MenuSectionsSelector.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

struct MenuSectionsSelector: View {
    @ObservedObject var viewModel: MenuViewModel
    @Namespace var namespace
    var pageProxy: ScrollViewProxy
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.sections, id: \.name) {    section    in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                scrollTo(section, proxy: proxy, pageProxy: pageProxy)
                            }
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
            }
            .padding(.vertical, 10)
            .background(
                ZStack {
                    Color.systemBackground
                    Color.white.opacity(0.2)
                }
            )
            .overlayDivider(.bottom)
            .onChange(of: viewModel.activeSection) { section in
                withAnimation {
                    proxy.scrollTo(section, anchor: UnitPoint(x: 0.6, y: 0))
                }
            }
        }
    }

    private func scrollTo(_ section: MenuSection, proxy: ScrollViewProxy, pageProxy: ScrollViewProxy) {
        if viewModel.activeSection != section.name {
            viewModel.activeSection    =    section.name
            proxy.scrollTo(viewModel.activeSection, anchor: UnitPoint(x: 0.6, y: 0))
            pageProxy.scrollTo(viewModel.activeSection, anchor: UnitPoint(x: 0, y: 0.1))
        }
    }
}
