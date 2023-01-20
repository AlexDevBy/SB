//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 15.02.2022.
//

import Foundation

public protocol URLConvertible {
	func asURL() throws -> URL
}

extension String: URLConvertible {
	public func asURL() throws -> URL {
		guard let url = URL(string: self) else { throw NCRESTError.invalidURL(url: self) }
		return url
	}
}

extension URL: URLConvertible {
	public func asURL() throws -> URL { self }
}

extension URLComponents: URLConvertible {
	public func asURL() throws -> URL {
		guard let url = url else { throw NCRESTError.invalidURL(url: self) }

		return url
	}
}

public protocol URLRequestConvertible {
	func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
	public var urlRequest: URLRequest? { try? asURLRequest() }
}

extension URLRequest: URLRequestConvertible {
	public func asURLRequest() throws -> URLRequest { self }
}
