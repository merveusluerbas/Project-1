//
//  APIError.swift
//  PlantsLoveApp
//
//  Created by Merve Uslu Erbas on 25/7/24.
//

import Foundation

enum APIError: Error {
    case internetConnection
    case serviceError
    case wrongRequest
    case unexpectedStatusCode
    case decode
    case unknown
}
