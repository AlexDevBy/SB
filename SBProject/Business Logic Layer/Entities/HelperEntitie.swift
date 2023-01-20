//
//  Link.swift
//  Pixpot
//
//  Created by Vladimir on 15.01.2023.
//

import Foundation

struct Link: Decodable {
    let link: String
}

struct EmptyStruct: Decodable {
    
}




// MARK: - Welcome
struct PushAnswer: Decodable {
    let resultCode: Int
    let message: String
    let data: PushData

    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case message, data
    }
}
struct PushData: Decodable {
    let save: Bool
}

// MARK: - DataClass
///{
//    "result_code": 200,
//    "message": "ok",
//    "data": {
//      "tabs": "1",
//      "ip": "89.64.77.153",
//      "country_code": "PL"
//    }
//  }
