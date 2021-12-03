//
//  ContentView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

struct HomeView: View {
    @State private var isLoggedIn = AuthServiceFactory.create().token != nil

    var body: some View {
        NavigationView {
            if isLoggedIn {
                MenuView()
            } else {
                SignInView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
