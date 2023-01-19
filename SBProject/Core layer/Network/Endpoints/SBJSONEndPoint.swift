//
//  BlazrJSONEndPoint.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 17.12.2022.
//

import Foundation
import Alamofire

enum SBJSONEndPoint: ApiConfiguration {
    case link
    
    var method: HTTPMethod {
        switch self {
        case .link:
            return .get
        }
    }

    var path: String {
        switch self {
        case .link:
            return ""
        }
    }
    
    var parameters: [String: Any]? {
        return [:]
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            return HTTPHeaders(
                [:]
            )
        }
    }
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: ApiConstants.URL.countryLink)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        return urlRequest
    }
}
