//
//  APIService.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// The endpoints for the api resources.
enum API {
    
    /// The base URL for all API requests.
    static let baseURL  =   URL(string: "http://127.0.0.1:8090/api/")
    
    
    /// A collection of endpoints for User activity.
    enum User: String {
        
        /// The endpoint for checking email availability.
        case checkEmail = "users/checkemail/"
        
        /// The endpoint for signing up a user.
        case signUp = "users/signup/"
        
        /// The endpoint for signing in a user.
        case signIn = "users/signin/"
        
        /// The endpoint for signing out a user.
        case signOut = "users/signout/"
    }
    
    /// A collection of endpoints for fetching menu data.
    enum Menu: String {
        
        /// The endpoint for fetching the menu sections.
        case fetchMenu = "menu/"
    }
    
    /// A collection of endpoints for Cart operations.
    enum Cart: String {
        
        /// The endpoint for fetching the contents of the user's cart.
        case fetchContents = "carts/contents/"
        
        /// The endpoint for adding items to the user's cart.
        case addItem = "carts/add/"
        
        /// The endpoint for removing items from the user's cart.
        case removeItem = "carts/remove/"
    }
    
    /// A collection of endpoints for fetching Food details.
    enum Food: String {
        
        /// The endpoint for fetching the options for the food.
        case fetchOptions = "options/"
    }
}
