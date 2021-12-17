//
//  SwiftCafeApp.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

@main
/// #The entry point for the application.
struct SwiftCafeApp: App {

    /// A boolean state that represents whether the user is signed in or not.
    /// A value for the token means that the user is signed in.
    /// If the token is nil then the user's session expired.
    @State private var isSignedIn = AuthServiceFactory.create().token != nil

    var body: some Scene {
        WindowGroup {
            if isSignedIn {
                MenuView()
            } else {
                SignInView(isSignedIn: $isSignedIn)
            }
        }
    }
}
