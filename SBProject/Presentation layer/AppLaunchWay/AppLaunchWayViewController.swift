//
//  AppLaunchWayViewController.swift
//  SBProject
//
//  Created by Alex Misko on 16.01.2023.
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
    
    // MARK: - Properties
    private let countryData = PassthroughSubject<CountryEntitie, Never>()
    private let getLink = PassthroughSubject<String, Never>()
    private let countryService: CountryServiceProtocol
    private let helperService: HelperServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Output
    var appWay: ((LaunchInstructor) -> Void)?
    
    // MARK: - Init
    init(
        countryService: CountryServiceProtocol,
        helperService: HelperServiceProtocol
    ) {
        self.countryService = countryService
        self.helperService = helperService
    }
    
    // MARK: - AppLaunchWayViewModelProtocol
    private func sinkData() {
        countryData
            .sink { [weak self] data in
                guard let self = self else {return}
                if data.data.tabs == "2" {
                    self.appWay?(.push)
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
    
    func fetchData() {
        sinkData()
        getCountry()
    }
    
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
