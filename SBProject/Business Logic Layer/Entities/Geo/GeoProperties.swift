//
//  GeoProperties.swift
//  Pixpot
//
//  Created by Vladimir on 15.01.2023.
//

import Foundation

struct GeoProperties: Codable {
    let name: String
    let country: String
    let city: String
    let postcode: String
    let categories: [String]
}
