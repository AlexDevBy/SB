//
//  MockData.swift
//  Sarawan
//
//  Created by Евгений Юнкин on 23.12.22.
//

import Foundation

// временная локальная база, УДАЛИТЬ ПОСЛЕ ДОБАВЛЕНИЯ БЭКА
struct ListItem {
    let name: String
    let adress: String
    let imageBig: String
    let imageSmall: String
    let imageObjectOnly: String
    let category: GeoPlace
}



enum ListSection {
    case headSection([ListItem])

    var items: [ListItem] {
        switch self {
        case .headSection(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
  
}



struct MockData {
    
    static let shared = MockData()
    
    
    
    let headSection: ListSection = {
        .headSection([
            .init(name: "BasketBall",
                  adress: "",
                  imageBig: "BasketBallBig",
                  imageSmall: "BasketballSmall",
                  imageObjectOnly: "BasketballObj",
                  category: .baseSport),
            
            .init(name: "Football",
                  adress: "",
                  imageBig: "FootballBig",
                  imageSmall: "FootballSmall",
                  imageObjectOnly: "FootballObj",
                  category:  .baseSport),
            
            .init(name: "Volley",
                  adress: "",
                  imageBig: "VolleyBig",
                  imageSmall: "VolleySmall",
                  imageObjectOnly: "VolleyObj",
                  category: .baseSport),
            
            .init(name: "Running",
                  adress: "",
                  imageBig: "RunningBig",
                  imageSmall: "RunningSmall",
                  imageObjectOnly: "RunningObj",
                  category: .running),
            
            .init(name: "Gymnastics",
                  adress: "",
                  imageBig: "GymnasticsBig",
                  imageSmall: "GymnasticsSmall",
                  imageObjectOnly: "GymnasticsObj",
                  category: .gymnastics),
            
            .init(name: "Swimming",
                  adress: "",
                  imageBig: "SwimmingBig",
                  imageSmall: "SwimmingSmall",
                  imageObjectOnly: "SwimmingObj",
                  category: .swimming),
            
            .init(name: "Martial",
                  adress: "",
                  imageBig: "MartialBig",
                  imageSmall: "MartialSmall",
                  imageObjectOnly: "MartialObj",
                  category: .martial),
            
            .init(name: "Ski",
                  adress: "",
                  imageBig: "SkiBig",
                  imageSmall: "SkiSmall",
                  imageObjectOnly: "SkiObj",
                  category: .ski)

        ])
    }()
    
  
  
    var selectedCategory: GeoPlace = .baseSport
    var selectedIndex: IndexPath?
    
    
    var pageData: [ListSection] {
        [headSection]
    }
    
    
    
    
}


