//
//  ProductEntitie.swift
//  SBProject
//
//  Created by Alex Misko on 09.12.2022.
//

import Foundation

// MARK: - ProductEntitie
struct ProductEntitie: Codable {
    let cpu, camera: String
    let capacity, color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd, ssd, title: String

    enum CodingKeys: String, CodingKey {
        case cpu = "CPU"
        case camera, capacity, color, id, images, isFavorites, price, rating, sd, ssd, title
    }
    
    init() {
        cpu = ""
        camera = ""
        capacity = []
        color = []
        id = ""
        images = []
        isFavorites = false
        price = 0
        rating = 0
        sd = ""
        ssd = ""
        title = ""
    }
}
