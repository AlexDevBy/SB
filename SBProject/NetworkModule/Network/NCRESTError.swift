//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 15.02.2022.
//

import Foundation

enum NCRESTError :Error {
	case invalidURL(url: URLConvertible)
	case parameterEncodingFailed
}
