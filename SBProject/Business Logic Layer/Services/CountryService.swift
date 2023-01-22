//
//  CountryService.swift
//  SBProject
//
//  Created by Alex Misko on 13.01.23.
//

import Foundation

protocol CountryServiceProtocol {
    func getCountry(_ completion: @escaping ObjCompletion<Result<CountryEntitie, CountryServiceError>>)
}

enum CountryServiceError: Error {
    case unknown
}

final class CountryService: CountryServiceProtocol {
    
    private let apiClient: NetworkProviderProtocol
    
    init(apiClient: NetworkProviderProtocol) {
        self.apiClient = apiClient
    }
    
    func getCountry(_ completion: @escaping ObjCompletion<Result<CountryEntitie, CountryServiceError>>) {
        apiClient.request(CountryEntitie.self, endpoint: Endpoint.country) { response in
            switch response {
            case let .success(country):
                completion(.success(country))
            case let .failure(error):
                debugPrint(error)
                completion(.failure(.unknown))
            }
        }
    }
   
}
