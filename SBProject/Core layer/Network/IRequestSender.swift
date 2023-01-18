//
//  IRequestSender.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import Foundation
import Alamofire

struct ApiRequestConfig<Parser> where Parser: IParser {
    let endPoint: ApiConfiguration
    let parser: Parser
}

protocol IRequestSender {
    @discardableResult
    func send<Parser>(requestConfig: ApiRequestConfig<Parser>,
                      completionHandler: @escaping (Swift.Result<Parser.Model, NetworkError>) -> Void) -> DataRequest where Parser : IParser
}
