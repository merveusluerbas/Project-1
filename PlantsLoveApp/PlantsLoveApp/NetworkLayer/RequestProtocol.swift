//
//  RequestProtocol.swift
//  PlantsLoveApp
//
//  Created by Merve Uslu Erbas on 25/7/24.
//

import Foundation

protocol Request {
    var endpoint: APIEndpoint { get }
    var timeout: Double { get }
    func createURLRequest() -> URLRequest?
}

extension Request {
    var timeout: Double {
        return 20
    }
    
    func createURLRequest() -> URLRequest? {
        guard let url = endpoint.createURL() else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        if let body = endpoint.body {
            let encoder = JSONEncoder()
            request.httpBody = try? encoder.encode(body)
        }
        return request
    }
}
