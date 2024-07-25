//
//  PlantsNetworkRequest.swift
//  PlantsLoveApp
//
//  Created by Merve Uslu Erbas on 25/7/24.
//

import Foundation
//sk-Zzbv66a287d4441a46332

struct PlantsNetworkRequest: Request {
    var endpoint: any APIEndpoint = PlantsEndpoint(type: .speciesList)
}

struct PlantsEndpoint: APIEndpoint {
    let type: PlantsPathEnum
    
    init(type: PlantsPathEnum) {
        self.type = type
        self.path = type.rawValue
    }
    
    var baseURL: String = "perenual.com"
    
    var path: String
    
    var parameter: [URLQueryItem]? = [URLQueryItem(name: "key", value: "sk-Zzbv66a287d4441a46332")]
    
    var header: [String : String]?
    
    var body: [String : String]?
    
    var method: HTTPMethod = .get
    
    var scheme: URLScheme = .https
}
