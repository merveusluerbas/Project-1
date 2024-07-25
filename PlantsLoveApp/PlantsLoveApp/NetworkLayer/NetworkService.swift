//
//  NetworkService.swift
//  PlantsLoveApp
//
//  Created by Merve Uslu Erbas on 25/7/24.
//

import Foundation
import Combine

protocol NetworkService {
    func send<T: Decodable>(_ request: Request) -> AnyPublisher<T, APIError>
    func send<T: Decodable>(_ request: Request, resultHandler: @escaping (Result<T, APIError>) -> Void)
}

final class NetworkServiceLive: NetworkService {
    func send<T: Decodable>(_ request: any Request) -> AnyPublisher<T, APIError> {
        guard let urlRequest = request.createURLRequest() else {
            precondition(false, "Failed URL Request")
        }
        
         return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    throw APIError.unexpectedStatusCode
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return APIError.serviceError
            }
            .eraseToAnyPublisher()
    }
    
    func send<T: Decodable>(_ request: any Request, resultHandler: @escaping (Result<T, APIError>) -> Void) {
        guard let urlRequest = request.createURLRequest() else {
            resultHandler(.failure(.wrongRequest))
            return
        }
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in 
            if error != nil {
               // TODO: Search about error.localizedDescription is meaningful or not
                resultHandler(.failure(.internetConnection))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                resultHandler(.failure(.unexpectedStatusCode))
                return
            }
            
            guard let data else {
                resultHandler(.failure(.unknown))
                return
            }
            
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(T.self, from: data) else {
                resultHandler(.failure(.decode))
                return
            }
            resultHandler(.success(decodedData))
        }
        
        urlTask.resume()
    }
}
