//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 15.02.2022.
//

import Foundation

public protocol URLConvertible1 {
	func asURL() throws -> URL
}

extension String: URLConvertible1 {
	public func asURL() throws -> URL {
		guard let url = URL(string: self) else { throw NCRESTError.invalidURL(url: self) }
		return url
	}
}

extension URL: URLConvertible1 {
	public func asURL() throws -> URL { self }
}

extension URLComponents: URLConvertible1 {
	public func asURL() throws -> URL {
		guard let url = url else { throw NCRESTError.invalidURL(url: self) }

		return url
	}
}

public protocol URLRequestConvertible1 {
	func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible1 {
	public var urlRequest: URLRequest? { try? asURLRequest() }
}

extension URLRequest: URLRequestConvertible1 {
	public func asURLRequest() throws -> URLRequest { self }
}
