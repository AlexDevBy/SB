//
//  HelperService.swift
//  Pixpot
//
//  Created by Vladimir on 15.01.2023.
//

import Foundation

protocol HelperServiceProtocol {
    func getBroswerLink(_ completion: @escaping ObjCompletion<Result<Link, HelperServiceError>>)
}

enum HelperServiceError: Error {
    case unknown
}

final class HelperService: HelperServiceProtocol {
    private let apiClient: NetworkProviderProtocol
    
    init(apiClient: NetworkProviderProtocol) {
        self.apiClient = apiClient
    }
    
    func getBroswerLink(_ completion: @escaping ObjCompletion<Result<Link, HelperServiceError>>) {
        apiClient.request([Link].self, endpoint: Endpoint.link) { response in
            switch response {
            case .success(let links):
                guard let firstLink = links.first else {
                    completion(.failure(.unknown))
                    return
                }
                completion(.success(firstLink))
            case .failure(let error):
                debugPrint(error)
                completion(.failure(.unknown))
            }
        }
    }
    
}
