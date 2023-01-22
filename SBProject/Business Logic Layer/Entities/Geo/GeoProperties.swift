//
//  GeoProperties.swift
//  SBProject
//
//  Created by Alex Misko on 15.01.2023.
//

import Foundation

struct GeoProperties: Codable {
    let name: String?
    let country: String
    let city: String
    let postcode: String
    let formatted: String
    let address_line1: String
    let address_line2: String
    let categories: [String]
}
