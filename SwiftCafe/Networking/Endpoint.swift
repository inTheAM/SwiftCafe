//
//
//  Endpoint.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/03/2022.
//

import Foundation

/// #An endpoint in the API Spec.
/// #Each Endpoint must have an accessLevel, a payload type and a response type.
struct Endpoint<AccessLevel: AccessLevelProtocol, Payload: Encodable, Response: Decodable> {
    let path: String
}

// MARK: - USER & AUTH ENDPOINTS:

/// #Checking email availability.
extension Endpoint where AccessLevel == PublicAccess,
                         Payload == User.EmailCheckData,
                         Response == User.EmailCheckResult {

    static let checkEmail: Self = Endpoint(path: "users/checkemail/")
}

/// #Signing up a user.
extension Endpoint where AccessLevel == SignUpAccess,
                            Payload == User.SignInData,
                            Response == Token {
    static let signUp: Self = Endpoint(path: "users/signup/")

}

/// #Signing in a user.
extension Endpoint where AccessLevel == SignInAccess,
                            Payload == User.SignInData,
                            Response == Token {
    static let signIn: Self = Endpoint(path: "users/signin/")
}

/// #Signing out a user.
extension Endpoint where AccessLevel == PrivateAccess,
                            Payload == EmptyPayload,
                            Response == EmptyResponse {
    static let signOut: Self = Endpoint(path: "users/signout/")
}

// MARK: - CART ENDPOINTS:

/// #Fetching the user's cart.
extension Endpoint where AccessLevel == PrivateAccess,
                            Payload == EmptyPayload,
                            Response == [Cart.Entry] {
    static let fetchCartContents: Self = Endpoint(path: "cart/")
}

/// #Adding an item to the user's cart.
extension Endpoint where AccessLevel == PrivateAccess,
                            Payload == Cart.Entry.CreateData,
                            Response == Cart.Entry? {
    static let addItemToCart: Self = Endpoint(path: "cart/add/")
}

/// #Removing an item from the user's cart.
extension Endpoint where AccessLevel == PrivateAccess,
                            Payload == Cart.Entry.RemoveData,
                            Response == EmptyResponse {
    static let removeItemFromCart: Self = Endpoint(path: "cart/remove/")
}

// MARK: - MENU & FOOD ENDPOINTS
/// #Fetching the menu sections.
extension Endpoint where AccessLevel == PrivateAccess,
                            Payload == EmptyPayload,
                            Response == [MenuSection] {
    static let fetchMenu: Self = Endpoint(path: "menu/")
}

/// #Fetching the options for the selected food.
extension Endpoint where AccessLevel == PrivateAccess,
                            Payload == EmptyPayload,
                            Response == [OptionGroup] {
    static func fetchItemOptions(_ id: UUID) -> Self {
        return Endpoint(path: "options/\(id.uuidString)")
    }
}
