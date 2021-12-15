//
//  RequestError.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

/// The error received in case of a failure handling a network request.
enum RequestError: String, Error {
    /// A failure caused by an invalid URL
    case invalidURL =   "Invalid URL."

    /// A failure caused by invalid data in the network response.
    case invalidDataFromServer =   "No data from server."

    /// A failure caused by and invalid network response.
    case invalidResponseFromServer = "Invalid response from server."

    /// A failure to decode the data received in the network response.
    case failedToDecodeData  =   "Unable to decode data from server."

    /// A failure caused by attempting an unauthorized request when some form of authorization is required.
    case unauthorizedRequest = "Unauthorized request."
}
