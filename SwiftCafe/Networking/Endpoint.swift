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
struct Endpoint<Payload: Encodable, Response: Decodable> {
    let httpMethod: RequestType
    let accessLevel: AccessLevel
    let mainPath: MainPath
    let path: String?

    init(_ method: RequestType, accessLevel: AccessLevel = .token, mainPath: MainPath, path: String? = nil) {
        self.httpMethod = method
        self.accessLevel = accessLevel
        self.mainPath = mainPath
        self.path = path
    }

    /// Creates a `URL` from a given path
    /// - Parameter path: The path to create a url from.
    /// - Returns: An optional URL.
    func makeURL() -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
        components.path = "/api/\(mainPath.rawValue)/" + (path ?? "")

        guard let url = components.url else {
            preconditionFailure("Invalid URL at \(components.path)")
        }
        return url
    }

    enum MainPath: String {
        case users,
             menu,
             carts
    }
}

// MARK: - USER & AUTH ENDPOINTS:

/// #Checking email availability.
extension Endpoint where Payload == User.EmailCheckData,
                         Response == User.EmailCheckResult {

    static let checkEmail: Self = Endpoint(.post, accessLevel: .publicAccess, mainPath: .users, path: "email/")
}

/// #Signing up a user.
extension Endpoint where Payload == User.SignInData,
                            Response == Token {
    static let signUp: Self = Endpoint(.post, accessLevel: .publicAccess, mainPath: .users)

}

/// #Signing in a user.
extension Endpoint where Payload == User.SignInData,
                            Response == Token {
    static func signIn(_ authData: String) -> Self {
        Endpoint(.post, accessLevel: .basic(authData), mainPath: .users, path: "session/")
    }
}

/// #Signing out a user.
extension Endpoint where Payload == EmptyPayload,
                            Response == EmptyResponse {
    static let signOut: Self = Endpoint(.delete, mainPath: .users, path: "session/")
}

extension Endpoint where Payload == EmptyPayload,
                         Response == EmptyResponse {
    static let deleteAccount: Self = Endpoint(.delete, accessLevel: .token, mainPath: .users)
}

// MARK: - CART ENDPOINTS:

/// #Fetching the user's cart.
extension Endpoint where Payload == EmptyPayload,
                            Response == Cart {
    static let fetchCart: Self = Endpoint(.get, mainPath: .carts)
}

/// #Adding an item to the user's cart.
extension Endpoint where Payload == Cart.Entry.CreateData,
                            Response == Cart.Entry? {
    static let addItemToCart: Self = Endpoint(.post, mainPath: .carts)
}

/// #Removing an item from the user's cart.
extension Endpoint where Payload == Cart.Entry.RemoveData,
                            Response == EmptyResponse {
    static let removeItemFromCart: Self = Endpoint(.delete, mainPath: .carts)
}

extension Endpoint where Payload == EmptyPayload,
                         Response == EmptyResponse {
    static let clearCartContents: Self = Endpoint(.delete, accessLevel: .token, mainPath: .carts, path: "clear")
}

// MARK: - MENU & FOOD ENDPOINTS
/// #Fetching the menu sections.
extension Endpoint where Payload == EmptyPayload,
                            Response == [MenuSection] {
    static let fetchMenu: Self = Endpoint(.get, mainPath: .menu)
}

/// #Fetching the options for the selected food.
extension Endpoint where Payload == EmptyPayload,
                            Response == [OptionGroup] {
    static func fetchItemOptions(_ id: UUID) -> Self {
        Endpoint(.get, mainPath: .menu, path: "options/\(id.uuidString)")
    }
}
