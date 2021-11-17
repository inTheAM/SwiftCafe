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
    
    @ViewBuilder func flash (_ section: String) -> some View {
        if isFlashing && section == viewModel.activeSection {
            Color.primary.opacity(0.1)
        }
    }
    
    var body: some View {
        ScrollViewReader { pageProxy in
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: MenuSectionsSelector(viewModel: viewModel, pageProxy: pageProxy))    {
                        ForEach(viewModel.sections) { section in
                            //                      Section Views
                        }
                        
                    }
                    .onAppear    {
                        viewModel.fetchMenu()
                    }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
