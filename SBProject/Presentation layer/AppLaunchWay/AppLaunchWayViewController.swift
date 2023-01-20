//
//  AppLaunchWayViewController.swift
//  Pixpot
//
//  Created by Vladimir on 16.01.2023.
//


import Foundation
import Combine

protocol AppLaunchWayViewModelProtocol {
    func fetchData()
}

protocol AppLaunchOutput: AnyObject {
    var appWay: ((LaunchInstructor) -> Void)? { get set }
}

final class AppLaunchWayViewModel: AppLaunchWayViewModelProtocol, AppLaunchOutput {
    
    // MARK: - Output
    var appWay: ((LaunchInstructor) -> Void)?

    // MARK: - Properties
    private let countryData = PassthroughSubject<CountryEntitie, Never>()
    private let getLink = PassthroughSubject<String, Never>()
    private let countryService: CountryServiceProtocol
    private let helperService: HelperServiceProtocol
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Init
    init(
        countryService: CountryServiceProtocol,
        helperService: HelperServiceProtocol
    ) {
        self.countryService = countryService
        self.helperService = helperService
    }
    
    // MARK: - AppLaunchWayViewModelProtocol
    
    func fetchData() {
        sinkData()
        getCountry()
    }
    
    private func sinkData() {
        countryData
            .sink { [weak self] data in
                guard let self = self else {return}
                if data.data.tabs == "1" {
                    self.appWay?(.locationVerify)
                } else {
                    self.linkRequest()
                }
            }
            .store(in: &cancellable)
        
        getLink
            .sink { [weak self] link in
                self?.appWay?(.webView(link))
            }
            .store(in: &cancellable)
    }
    
    
}

// MARK: - Public Api
extension AppLaunchWayViewModel {
    
    func getCountry() {
        countryService.getCountry { [weak self] result in
            switch result {
            case .success(let country):
                self?.countryData.send(country)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func linkRequest() {
        helperService.getBroswerLink { [weak self] result in
            switch result {
            case .success(let link):
                self?.getLink.send(link.link)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
