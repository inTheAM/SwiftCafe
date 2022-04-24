//
//  MenuView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

/// #The main view that displays the cafe menu.
struct MenuView: View {

    /// The view model that manages this view.
    /// An instance of `MenuViewModel`.
    @StateObject var viewModel = MenuViewModel()

    /// The user's cart, injected into the environment.
    @ObservedObject var cart = Cart()
    
    /// A binding to a boolean that indicates whether the user is signed in or not.
    /// A successful sign-up toggles the value to true.
    @Binding var isSignedIn: Bool
    
    /// A namespace for matching the geometry effect of the selector between sections.
    @Namespace var namespace
    
//    @State private var activeSection = ""

    /// The Menu overlaid with a button to show the user's cart.
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                MenuSectionsSelector(viewModel: viewModel)
                
                ScrollViewReader { pageProxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                            ForEach(viewModel.sections) { section in
                                Section(header: HeaderView(title: section.name)) {
                                    VStack {
                                        ForEach(section.items) { food in
                                            FoodCardView(food: food)
                                        }
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal)
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
                        .onChange(of: viewModel.activeSection) { section in
                            #warning("'withAnimation' breaks autoscroll")
                            pageProxy.scrollTo(section, anchor: UnitPoint(x: 0, y: 0))
                        }
                        
                    }
                    .accessibilityIdentifier("menu")
                }
                
            }
            .overlay(CartButton())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LocationButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sign out") {
                        viewModel.signOut {
                            isSignedIn = false
                            print("Signed out")
                        }
                    }
                }
            }
        }
        .environmentObject(cart)
    }

    private func activateSection(_ section: MenuSection, in rect: CGRect) {
        if rect.minY < 360 && rect.maxY > 520 && section.name != viewModel.activeSection {
            viewModel.activeSection = section.name
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isSignedIn: .constant(true))
    }
}
