//
//  ApiConfiguration.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import Foundation
import Alamofire

protocol ApiConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
}
