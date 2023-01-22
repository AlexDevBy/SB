//
//  HelperService.swift
//  SBProject
//
//  Created by Alex Misko on 15.01.2023.
//

import Foundation

protocol HelperServiceProtocol {
    func getBroswerLink(_ completion: @escaping ObjCompletion<Result<Link, HelperServiceError>>)
    func sendPushToken(token: String, country: String, _ completion: @escaping ObjCompletion<Result<PushAnswer, HelperServiceError>>)
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
    
    
    func sendPushToken(token: String, country: String, _ completion: @escaping ObjCompletion<Result<PushAnswer, HelperServiceError>>) {
        apiClient.request(PushAnswer.self, endpoint: Endpoint.pushNotification(token: token, country: country)) { response in
            switch response {
            case .success(let response):
                 let empty = response
                print(empty.message)
                completion(.success(empty))
            case .failure(let error):
                debugPrint(error)
                completion(.failure(.unknown))
            }

        }
    }
    
}
