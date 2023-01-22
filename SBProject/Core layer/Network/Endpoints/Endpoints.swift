//
//  Endpoints.swift
//  SBProject
//
//  Created by Alex Misko on 15.01.2023.
//

import Foundation

enum Endpoint: RestEndpoint {
    case country
    case link
    case pushNotification(token: String, country: String)
    case geoApi(category: String, filter: String, limit: Int, apiKey: String)
    
    var server: Server {
        switch self {
        case .country, .link, .pushNotification:
            return SBServers.default
        case .geoApi:
            return SBServers.geo
            
        }
    }
    
    var path: String {
        switch self {
        case .country:
            return "/api/getCountry"
        case .link:
            return "/user/auth.json"
        case .geoApi:
            return "places"
        case .pushNotification:
            return "/api/push/"
        }
    }
//    /?debug=true
    var httpMethod: HTTPMethod {
        switch self {
        case .country, .link, .geoApi:
            return .get
        case .pushNotification:
            return .post
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
        case .pushNotification:
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
        case .pushNotification(let params):
            return [
                "token": params.token,
                "country": params.country
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
        case .pushNotification:
            return .httpBody
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .country, .link, .geoApi:
            return URLEncoding.default
        case .pushNotification:
            return JSONEncoding.default
        }
    }
    
    
}
