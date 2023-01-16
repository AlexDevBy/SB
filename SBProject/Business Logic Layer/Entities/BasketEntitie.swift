//
//  BasketEntitie.swift
//  TaskEffectiveMobile
//
//  Created by Admin on 09.12.2022.
//

import Foundation

// MARK: - BasketEntitie
struct BasketEntitie: Decodable {
    var basket: [Products]
    let delivery, id: String
    let total: Int
}

// MARK: - Basket
struct Products: Codable {
    let id: Int
    let images: String
    let price: Int
    let title: String
    private var _count: Int? 
    var count: Int {
        get { _count ?? 1}
        set { _count = newValue}
    }
    
    enum CodingKeys: String, CodingKey {
            case _count = "count"
            case id, images, price, title
        }
}
