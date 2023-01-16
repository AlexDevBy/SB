//
//  CountryEntitie.swift
//  Pixpot
//
//  Created by Евгений Юнкин on 13.01.23.
//

import Foundation

// MARK: - Welcome
struct CountryEntitie: Codable {
    let resultCode: Int
    let message: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case message, data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let tabs, ip, countryCode: String

    enum CodingKeys: String, CodingKey {
        case tabs, ip
        case countryCode = "country_code"
    }
}

