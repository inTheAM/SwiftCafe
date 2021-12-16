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

    /// The state that represents whether the user is signed in or not.
    /// A present value for the token means that the user is signed in.
    /// A value of nil for the token indicates that the user's session expired.
    @State private var isLoggedIn = true /*AuthServiceFactory.create().token != nil*/

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
