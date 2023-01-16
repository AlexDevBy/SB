//
//  DIContainer.swift
//  TaskEffectiveMobile
//
//  Created by Admin on 09.12.2022.
//

import Foundation

final class DIContainer {
    private let apiClient: NetworkProviderProtocol
    
    let countryService: CountryServiceProtocol
    let helperService: HelperServiceProtocol
    
    init() {
        apiClient = NetworkSessionProvider.shared
        self.countryService = CountryService(apiClient: apiClient)
        self.helperService = HelperService(apiClient: apiClient)
    }
}
