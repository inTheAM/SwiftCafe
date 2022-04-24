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
    /// On launch, the application will always use the token to check if the user has an active session.
    /// A value for the token means that the user is signed in and the app proceeds to the MenuView.
    /// If the token is nil then the user's session expired and the app proceeds to the SignInView.
    /// On successful sign-in, this state will be toggled to true and the MenuView will be presented.
    @State private var isSignedIn = TokenStoreFactory.create().token != nil

    var body: some Scene {
        WindowGroup {
            if isSignedIn {
                MenuView(isSignedIn: $isSignedIn)
            } else {
                SignInView(isSignedIn: $isSignedIn)
            }
        }
    }
}
