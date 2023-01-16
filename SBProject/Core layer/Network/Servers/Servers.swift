//
//  Servers.swift
//  Pixpot
//
//  Created by Vladimir on 15.01.2023.
//

import Foundation

enum PixpotServers: Server {
    case `default`
    case geo
    
    var scheme: ServerScheme {
        return .https
    }
    
    var host: String {
        switch self {
        case .default:
            return "startingapp.website"
        case .geo:
            return "geoapify.com"
        }
    }
    
    var subdomain: String? {
        switch self {
        case .default:
            return nil
        case .geo:
            return "api"
        }
    }
    
    var subcomponent: String? {
        switch self {
        case .default:
            return nil
        case .geo:
            return "v2"
        }
    }
    
    var port: Int? {
        return nil
    }
    
    
}
