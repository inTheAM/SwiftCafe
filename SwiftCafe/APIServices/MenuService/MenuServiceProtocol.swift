//
//  MenuServiceProtocol.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 15/12/2021.
//

import Foundation

/// A protocol for services that handle fetching the menu.
protocol MenuServiceProtocol {

    /// A type representing a closure that takes a result containing either an array of MenuSection or a RequestError.
    /// The closure returns nothing.
        typealias MenuHandler = (Result<[MenuSection], RequestError>) -> Void

    /// Fetches an array of MenuSection.
    /// - Parameters:
    ///   - completion: A closure the method runs when a result is received from the request.
    ///                 The closure takes a Result containing either an array of MenuSection or a RequestError.
    func fetchMenu(completion: @escaping MenuHandler)
}
