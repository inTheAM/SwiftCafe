//
//  RequestResult.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 06/05/2022.
//

import Foundation

/// # The result of a request with no return type.
enum RequestResult: Decodable {
    case success, failure
}
