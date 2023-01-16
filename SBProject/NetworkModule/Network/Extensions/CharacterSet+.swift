//
//  File.swift
//  
//
//  Created by VLADIMIR LEVTSOV on 15.02.2022.
//

import Foundation

extension CharacterSet {
	static let afURLQueryAllowed: CharacterSet = {
		let generalDelimitersToEncode = ":#[]@"
		let subDelimitersToEncode = "!$&'()*+,;="
		let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

		return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
	}()
}
