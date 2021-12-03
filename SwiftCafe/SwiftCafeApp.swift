//
//  SwiftCafeApp.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

@main
struct SwiftCafeApp: App {
    @ObservedObject var cart = Cart()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(cart)
        }
    }
}
