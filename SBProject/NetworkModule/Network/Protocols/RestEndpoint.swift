//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 15.02.2022.
//

import Foundation

public protocol RestEndpoint: URLRequestConvertible {
	var server: Server { get }
	var path: String { get }
	var httpMethod: HTTPMethod { get }
	var auth: AuthType { get }
	var encodingDestination: URLEncoding.Destination { get }
	var encoding: ParameterEncoding { get }
	var params: Parameters { get }
}

public extension RestEndpoint {
	var encodingDestination: URLEncoding.Destination {
		return .queryString
	}

	var encoding: ParameterEncoding {
		return URLEncoding.default
	}

	var httpHeaders: HTTPHeaders {
		return .default
	}

	func asURLRequest() throws -> URLRequest {
		return try URLRequest(with: self)
	}
}
