//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 15.02.2022.
//

import Foundation

public protocol ParameterEncoding {
	func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest
}

public struct URLEncoding: ParameterEncoding {
	public static var `default`: URLEncoding { URLEncoding() }

	public enum Destination {
		case methodDependent
		case queryString
		case httpBody

		func encodesParametersInURL(for method: HTTPMethod) -> Bool {
			switch self {
			case .methodDependent: return [.get, .head, .delete].contains(method)
			case .queryString: return true
			case .httpBody: return false
			}
		}
	}

	enum ArrayEncoding {
		case brackets
		case noBrackets

		func encode(key: String) -> String {
			switch self {
			case .brackets:
				return "\(key)[]"
			case .noBrackets:
				return key
			}
		}
	}

	enum BoolEncoding {
		case numeric
		case literal

		func encode(value: Bool) -> String {
			switch self {
				case .numeric:
					return value ? "1" : "0"
				case .literal:
					return value ? "true" : "false"
			}
		}
	}

	let destination: Destination
	let arrayEncoding: ArrayEncoding
	let boolEncoding: BoolEncoding

	init(
		destination: Destination = .methodDependent,
		arrayEncoding: ArrayEncoding = .brackets,
		boolEncoding: BoolEncoding = .numeric) {
		self.destination = destination
		self.arrayEncoding = arrayEncoding
		self.boolEncoding = boolEncoding
	}

	public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
		var urlRequest = try urlRequest.asURLRequest()

		guard let parameters = parameters else { return urlRequest }

		if let method = urlRequest.httpMethod,
			destination.encodesParametersInURL(for: HTTPMethod(rawValue: method)) {
			guard let url = urlRequest.url else {
				throw NCRESTError.parameterEncodingFailed
			}

			if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
				let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
				urlComponents.percentEncodedQuery = percentEncodedQuery
				urlRequest.url = urlComponents.url
			}
		} else {
			if urlRequest.headers["Content-Type"] == nil {
				urlRequest.headers.update(.contentType("application/x-www-form-urlencoded; charset=utf-8"))
			}

			urlRequest.httpBody = Data(query(parameters).utf8)
		}

		return urlRequest
	}

	func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
		var components: [(String, String)] = []
		switch value {
		case let dictionary as [String: Any]:
			for (nestedKey, value) in dictionary {
				components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
			}
		case let array as [Any]:
			for value in array {
				components += queryComponents(fromKey: arrayEncoding.encode(key: key), value: value)
			}
		case let number as NSNumber:
			if number.isBool {
				components.append((escape(key), escape(boolEncoding.encode(value: number.boolValue))))
			} else {
				components.append((escape(key), escape("\(number)")))
			}
		case let bool as Bool:
			components.append((escape(key), escape(boolEncoding.encode(value: bool))))
		default:
			components.append((escape(key), escape("\(value)")))
		}
		return components
	}

	func escape(_ string: String) -> String {
		string.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) ?? string
	}

	private func query(_ parameters: [String: Any]) -> String {
		var components: [(String, String)] = []

		for key in parameters.keys.sorted(by: <) {
			let value = parameters[key]!
			components += queryComponents(fromKey: key, value: value)
		}
		return components.map { "\($0)=\($1)" }.joined(separator: "&")
	}
}

public struct JSONEncoding: ParameterEncoding {
	public static var `default`: JSONEncoding { JSONEncoding() }

	let options: JSONSerialization.WritingOptions

	init(options: JSONSerialization.WritingOptions = []) {
		self.options = options
	}

	public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
		var urlRequest = try urlRequest.asURLRequest()

		guard let parameters = parameters else { return urlRequest }

		do {
			let data = try JSONSerialization.data(withJSONObject: parameters, options: options)

			if urlRequest.headers["Content-Type"] == nil {
				urlRequest.headers.update(.contentType("application/json"))
			}

			urlRequest.httpBody = data
		} catch {
			throw NCRESTError.parameterEncodingFailed
		}

		return urlRequest
	}
}

extension NSNumber {
	fileprivate var isBool: Bool {
		String(cString: objCType) == "c"
	}
}
