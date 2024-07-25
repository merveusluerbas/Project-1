//
//  APIEndpoint.swift
//  PlantsLoveApp
//
//  Created by Merve Uslu Erbas on 25/7/24.
//

import Foundation

protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var parameter: [URLQueryItem]? { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var method: HTTPMethod { get }
    var scheme: URLScheme { get }
    
    func createURL() -> URL?
}

enum URLScheme: String {
    case https
    case http
}

extension APIEndpoint {
    func createURL() -> URL? {
        var component = URLComponents()
        component.queryItems = parameter
        component.scheme = scheme.rawValue
        component.path = path
        component.host = baseURL
        
        return component.url
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
}
