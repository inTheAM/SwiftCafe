//
//  AuthError.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// The error received in case of an authentication failure.
enum AuthError: String, Error {

    case signUpFailed = "There was a problem creating your account.",
         signInFailed = "Your email or password is incorrect",
         signOutFailed = "There was a problem signing out."
}
