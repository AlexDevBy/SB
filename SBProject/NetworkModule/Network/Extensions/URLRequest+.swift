//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 15.02.2022.
//

import Foundation

extension URLRequest {

	public init(url: URLConvertible, method: HTTPMethod, headers: HTTPHeaders? = nil) throws {
		let url = try url.asURL()

		self.init(url: url)

		httpMethod = method.rawValue
		allHTTPHeaderFields = headers?.dictionary
	}
}

extension URLRequest {
	init(with endpoint: RestEndpoint) throws {
		let urlComps = URLComponents(with: endpoint)
		try self.init(url: urlComps, method: endpoint.httpMethod, headers: endpoint.httpHeaders)
		self = try endpoint.encoding.encode(self, with: endpoint.params)
	}
}

extension URLComponents {
	init(with endpoint: RestEndpoint) {
		let url = endpoint.server.url.appendingPathComponent(endpoint.path)
		self.init(url: url, resolvingAgainstBaseURL: false)!
	}
}
