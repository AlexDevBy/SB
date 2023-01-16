//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 15.02.2022.
//

import Foundation
import UIKit

public enum SessionProviderError: LocalizedError {
	case decodeError(Error)
	case nilData
	case badRequest
	case taskError(Error)
	case accessTokenRequired
	case unknownResponse
	case unknown
}

public final class NetworkSessionProvider: NetworkProviderProtocol {

	// MARK: - Singletone
	public static let shared: NetworkProviderProtocol = NetworkSessionProvider()

	// MARK: - Properties
	private let rootQueue = DispatchQueue(label: "com.nicity.NCNetwork.networkQueue")
	private let interceptor = RestAuthInterceptor()

	// MARK: - Services

	private lazy var session: URLSession = .shared

	// MARK: - Init
	private init() {}

	// MARK: - NetworkProviderProtocol
	public func request<T: Decodable>(
		_ model: T.Type,
		endpoint: RestEndpoint,
		completion: @escaping ObjCompletion<Result<T, SessionProviderError>>
	) {
		guard var request = try? endpoint.asURLRequest() else {
			completion(.failure(.badRequest))
			return
		}

		do {
			try interceptor.signRequest(&request, for: endpoint)
			
		} catch RestAuthInterceptorError.accessTokenRequired {
			debugPrint("non-valid access token for authorized only request")
			completion(.failure(.accessTokenRequired))
		} catch {
			debugPrint("Error while preparing url request for \(error)")
			completion(.failure(.unknown))
		}

		let task = session.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(.taskError(error)))
				return
			}
			guard let data = data else {
				completion(.failure(.nilData))
				return
			}
			guard let response = response as? HTTPURLResponse else {
				completion(.failure(.unknownResponse))
				return
			}

			switch response.statusCode {
				case 200...299:
					do {
						let obj = try JSONDecoder().decode(T.self, from: data)
						completion(.success(obj))
					} catch {
						completion(.failure(.decodeError(error)))
					}
				case 400:
					completion(.failure(.badRequest))
				default:
					completion(.failure(.unknown))
			}
		}

		task.resume()
	}
}
