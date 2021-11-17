//
//  RequestError.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

enum RequestError: String,Error    {
    case invalidURL =   "Invalid URL.",
         invalidDataFromServer =   "No data from server.",
         invalidResponseFromServer = "Invalid response from server.",
         failedToDecodeData  =   "Unable to decode data from server.",
         unauthorizedRequest = "Unauthorized request."
}
