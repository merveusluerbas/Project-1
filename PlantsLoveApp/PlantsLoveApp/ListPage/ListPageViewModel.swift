//
//  ListPageViewModel.swift
//  PlantsLoveApp
//
//  Created by Merve Uslu Erbas on 24/7/24.
//

import Foundation

final class ListPageViewModel {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchSpeciesListWithEscaping() {
        let request = PlantsNetworkRequest()
        networkService.send(request) { (result: Result<PlantsSpecies, APIError>) in
            switch result {
            case .success(let response):
                print("success", response.data?.count)
            case .failure(let error):
                print("error", error.localizedDescription)
            }
        }
    }
    
    func fetchSpeciesListWithCombine() {
        let request = PlantsNetworkRequest()
        let x = networkService.send(request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Request finished successfully.")
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
            }, receiveValue: { (response: PlantsSpecies) in
                print("value", response.data?.count ?? 0)
            })
        
    }
}
