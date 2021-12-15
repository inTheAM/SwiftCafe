//
//  RequestError.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// #The error received in case of a failure handling a network request.
enum RequestError: Error {
    /// A failure caused by an invalid URL
    case invalidURL

    /// A failure caused by invalid data in the network response.
    case invalidDataFromServer

    /// A failure caused by and invalid network response.
    case invalidResponseFromServer

    /// A failure to decode the data received in the network response.
    case failedToDecodeData

    /// A failure caused by attempting an unauthorized request when some form of authorization is required.
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
