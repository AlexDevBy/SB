//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 17.02.2022.
//

import Foundation
//import NCCredentialStorage
import Combine

enum RestAuthInterceptorError: Error {
	case accessTokenRequired
}

final class RestAuthInterceptor {

//	private var credentials: OauthCredentials?
	private var bag = Set<AnyCancellable>()

	init() {
		observeUpdates()
	}

	func signRequest(_ request: inout URLRequest, for endpoint: RestEndpoint) throws {
		switch endpoint.auth {
		case .bearer:
//			guard let token = credentials?.accessToken, !token.isEmpty else {
//				throw RestAuthInterceptorError.accessTokenRequired
//			}
//			request.headers.update(.authorization(bearerToken: token))
            break
		case .none:
			break
		case .optionalBearer:
//			if let token = credentials?.accessToken, !token.isEmpty {
//				request.headers.update(.authorization(bearerToken: token))
//			}
            break
		}
	}

	private func observeUpdates() {
//		StorageMediator.shared.authCredentialsPublisher.sink { [weak self] creds in
//			self?.credentials = creds
//		}.store(in: &bag)
	}

}
