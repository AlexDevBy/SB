//
//  GeoFilter.swift
//  SBProject
//
//  Created by Alex Misko on 15.01.2023.
//

import Foundation

enum GeoFilter {
    case circle(lat: Double, long: Double, radius: Int)
    
    var repr: String {
        switch self {
        case let .circle(lat, long, radius):
            return "circle:\(long),\(lat),\(radius)"
        }
    }
}
