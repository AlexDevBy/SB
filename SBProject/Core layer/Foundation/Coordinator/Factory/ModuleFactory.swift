//
//  BaseCoordinator.swift
//  SBProject
//
//  Created by Alex Misko on 11.01.23.
//

import Foundation

protocol ModuleFactoryProtocol {
    func makeAppWayLaunch() -> (vc: AppLaunchWayViewController, output: AppLaunchOutput)
    func makeMainModule() -> MainViewController
    func makeWebViewModule(site: String,title: String) -> WebViewController
}

final class ModuleFactory: ModuleFactoryProtocol {
    
    private lazy var container = DIContainer()
    
    func makeAppWayLaunch() -> (vc: AppLaunchWayViewController, output: AppLaunchOutput) {
        let vm = AppLaunchWayViewModel(
            countryService: container.countryService,
            helperService: container.helperService
        )
        let vc = AppLaunchWayViewController(viewModel: vm)
        return (vc, vm)
    }
    
    func makeWebViewModule(site: String,title: String) -> WebViewController {
        return WebViewController(site: site, title: title, withExitButton: false, withBackButton: false)
    }
    
    func makeMainModule() -> MainViewController {
        return MainViewController()
    }
    
}

