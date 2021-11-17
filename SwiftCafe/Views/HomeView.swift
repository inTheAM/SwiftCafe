//
//  ContentView.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

struct HomeView: View {
    @State private var isLoggedIn = false
    var body: some View {
        if isLoggedIn {
            
        } else {
            SignInView(isLoggedIn: $isLoggedIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
