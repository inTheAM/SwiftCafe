//
//  NetworkManager.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Combine
import Foundation

struct NetworkManager {

    /// Creates a `URL` from a given path
    /// - Parameter path: The path to create a url from.
    /// - Returns: An optional URL.
    private func makeURL(for path: String) -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1:8090/api/"
        components.path = path
        guard let url = components.url else {
            return nil
        }
        return url
    }

    /// Creates a `URLRequest`
    /// - Parameters:
    ///   - requestType: The type of request being made ie "get" or "post" etc.
    ///   - url: The url for the request
    /// - Returns: A URLRequest.
    private func makeRequest(
        _ requestType: RequestType,
        for url: URL
    ) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod  =   requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-type")

        return request
    }

    /// Attaches a payload to a URLRequest.
    /// - Parameters:
    ///   - payload: The data to attach to the body of the request.
    ///   - request: The request to attach the payload to.
    private func attach<Payload: Encodable>(_ payload: Payload, to request: inout URLRequest) {
        request.httpBody = try? JSONEncoder().encode(payload)
    }

    /// Creates a publisher that publishes either the response from a url request or a `RequestError`.
    /// - Parameters:
    ///   - requestType: The type of request being made ie "get" or "post" etc
    ///   - endpoint: The api endpoint for the resource being requested.
    ///   - payload: The data to attach to the request's body.
    /// - Returns: A publisher that publishes the response of the request on success
    ///            or a `RequestError` in case of failure.
    func makeRequestPublisher<Payload, Response>(
        endpoint: Endpoint<Payload, Response>,
        payload: Payload?
    ) -> AnyPublisher<Response, RequestError>
    where Payload: Encodable, Response: Decodable {
        let url = endpoint.makeURL()

        guard var request = makeRequest(endpoint.httpMethod, for: url) else {
            return Fail(
                error: RequestError.invalidURL
            ).eraseToAnyPublisher()
        }

        switch endpoint.accessLevel {
        case .basic(let authData):
            print("ADDING LOGIN DATA")
            request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        case .token:
            if let token = TokenStore.token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        default:
            break
        }

        if let payload = payload {
            attach(payload, to: &request)
        }

        dump(request)
        let decoder = JSONDecoder()

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.data)
            .decode(type: NetworkResponse<Response>.self, decoder: decoder)
            .map {
                dump($0)
                return $0.result
            }
            .mapError({ error in
                dump(error, name: "ERROR LOADING DATA: ")
                return RequestError.invalidDataFromServer
            })
            .eraseToAnyPublisher()
    }

    func makeRequestPublisher<Payload>(
        endpoint: Endpoint<Payload, EmptyResponse>,
        payload: Payload? = nil
    ) -> AnyPublisher<RequestResult, RequestError>
    where Payload: Encodable {
        let url = endpoint.makeURL()

        guard var request = makeRequest(endpoint.httpMethod, for: url) else {
            return Fail(
                error: RequestError.invalidURL
            ).eraseToAnyPublisher()
        }

        switch endpoint.accessLevel {
        case .basic(let authData):
            request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        case .token:
            if let token = TokenStore.token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        default:
            break
        }
        if let payload = payload {
            attach(payload, to: &request)
        }

        dump(request)

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.response)
            .map {
                dump($0)
                guard let response = $0 as? HTTPURLResponse else {
                    return .failure
                }
                switch response.statusCode {
                case 200:
                    return .success
                default:
                    return .failure
                }
            }
            .mapError({ error in
                dump(error, name: "ERROR LOADING DATA: ")
                return RequestError.invalidDataFromServer
            })
            .eraseToAnyPublisher()
    }
}
