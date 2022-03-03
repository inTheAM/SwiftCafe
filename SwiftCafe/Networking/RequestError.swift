//
//  RequestError.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #The error received in case of a failure handling a network request.
enum RequestError: Error {
    case invalidURL
    case invalidDataFromServer
    case invalidResponseFromServer
    case failedToDecodeData
    case unauthorizedRequest

    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidDataFromServer:
            return "No data from server."
        case .invalidResponseFromServer:
            return "Invalid response from server."
        case .failedToDecodeData:
            return "Unable to decode data from server."
        case .unauthorizedRequest:
            return "Unauthorized request."
        }
    }
}
