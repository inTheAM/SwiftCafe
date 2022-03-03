//
//  NetworkResponse.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 01/03/2022.
//

import Foundation

/// #A generic wrapper around any type that comes in the network response.
struct NetworkResponse<WrappedValue: Decodable>: Decodable {
    let result: WrappedValue
}

struct EmptyResponse: Decodable { }

struct EmptyPayload: Encodable { }
