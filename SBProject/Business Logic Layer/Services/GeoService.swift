//
//  GeoService.swift
//  Pixpot
//
//  Created by Vladimir on 15.01.2023.
//

import Foundation
import CodableGeoJSON

protocol GeoServiceProtocol {
    func getSportStadiums(place: GeoPlace, filter: GeoFilter, _ completion: @escaping ObjCompletion<Result<[SportStadium], GeoServiceError>>)
}

enum GeoServiceError: Error {
    case unknown
}

final class GeoService: GeoServiceProtocol {
    private let apiClient: NetworkProviderProtocol
    
    init(apiClient: NetworkProviderProtocol) {
        self.apiClient = apiClient
    }
    
    func getSportStadiums(place: GeoPlace, filter: GeoFilter, _ completion: @escaping ObjCompletion<Result<[SportStadium], GeoServiceError>>) {
        apiClient.request(
            GeoJSONFeatureCollection<PointGeometry, GeoProperties>.self,
            endpoint: Endpoint.geoApi(category: place.rawValue, filter: filter.repr, limit: 1, apiKey: GeoApiKey.key)) { response in
                switch response {
                case let .success(geoData):
                    let stadiums = geoData.features.map({ SportStadium(name: $0.properties?.name ?? "") })
                    completion(.success(stadiums))
                case let .failure(error):
                    debugPrint(error)
                    completion(.failure(.unknown))
                }
            }
    }
    
    
}
