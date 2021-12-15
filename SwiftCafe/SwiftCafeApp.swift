//
//  SwiftCafeApp.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

@main
struct SwiftCafeApp: App {
    @State private var isLoggedIn = AuthServiceFactory.create().token != nil
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MenuView()
            } else {
                SignInView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
