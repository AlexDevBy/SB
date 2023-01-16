//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 15.02.2022.
//

import Foundation

public protocol NetworkProviderProtocol: AnyObject {

	func request<T: Decodable>(
		_ model: T.Type,
		endpoint: RestEndpoint,
		completion: @escaping  ObjCompletion<Result<T, SessionProviderError>>
	)

}
