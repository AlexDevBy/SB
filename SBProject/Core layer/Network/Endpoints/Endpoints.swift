//
//  Endpoints.swift
//  Pixpot
//
//  Created by Vladimir on 15.01.2023.
//

import Foundation

enum Endpoint: RestEndpoint {
    case country
    case link
    case geoApi(category: String, filter: String, limit: Int, apiKey: String)


    var server: Server {
        switch self {
        case .country, .link:
            return PixpotServers.default
        case .geoApi:
            return PixpotServers.geo
        }
    }

    var path: String {
        switch self {
        case .country:
            return "/api/getCountry"
        case .link:
            return "/trs/get.json"
        case .geoApi:
            return "places"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .country, .link, .geoApi:
            return .get
        }
    }

    var auth: AuthType {
        switch self {
        case .country:
            return .optionalBearer
        case .link:
            return .optionalBearer
        case .geoApi:
            return .optionalBearer
        }
    }

    var params: Parameters {
        switch self {
        case .country, .link:
            return [:]
        case .geoApi(let params):
            return [
                "categories": params.category,
                "filter": params.filter,
                "limit": params.limit,
                "apiKey": params.apiKey
            ]
        }
    }

    var encodingDestination: URLEncoding.Destination {
        switch self {
        case .country:
            return .methodDependent
        case .link:
            return .methodDependent
        case .geoApi:
            return .queryString
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .country, .link, .geoApi:
            return URLEncoding.default
        }
    }


}
