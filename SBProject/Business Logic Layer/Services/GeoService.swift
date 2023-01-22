//
//  GeoService.swift
//  SBProject
//
//  Created by Alex Misko on 15.01.2023.
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
            endpoint: Endpoint.geoApi(category: place.rawValue, filter: filter.repr, limit: 10, apiKey: GeoApiKey.key)) { response in
                switch response {
                case let .success(geoData):
                    
                    let stadiums = geoData.features.map({ SportStadium(name: $0.properties?.name ?? "",
                                                                       country: $0.properties?.country ?? "",
                                                                       city: $0.properties?.city ?? "",
                                                                       postcode: $0.properties?.postcode ?? "",
                                                                       formatted: $0.properties?.formatted ?? "",
                                                                       address_line1: $0.properties?.address_line1 ?? "",
                                                                       address_line2: $0.properties?.address_line2 ?? ""
                                                                                                ) })
                    completion(.success(stadiums))
                case let .failure(error):
                    debugPrint(error)
                    completion(.failure(.unknown))
                }
            }
    }
    
    
}
