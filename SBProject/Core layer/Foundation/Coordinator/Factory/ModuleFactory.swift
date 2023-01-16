//
//  BaseCoordinator.swift
//  SB
//
//  Created by Alex Misko on 11.01.23.
//

import Foundation

protocol ModuleFactoryProtocol {
    func makeAppWayLaunch() -> (vc: AppLaunchWayViewController, output: AppLaunchOutput)
    //    func makeTabBarModule() -> TabBarController
    //    func makeCatalogFoodModule() -> CatalogFoodController
    //
    //    func makeNatificationModule() -> NatificationViewController
    //    func makeBusketModule() -> BusketViewController
    func makeMainModule() -> MainViewController
    //    func makeProductModule() -> ProductViewController
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
    
    //    func makeCatalogFoodModule() -> CatalogFoodController {
    //        let viewModel = CatalogFoodViewModel(productService: container.productService
    //        )
    //
    //        let controller = CatalogFoodController(viewModel: viewModel)
    //        return controller
    //    }
    
    func makeWebViewModule(site: String,title: String) -> WebViewController {
        return WebViewController(site: site, title: title, withExitButton: false, withBackButton: false)
    }
    //
    //    func makeTabBarModule() -> TabBarController {
    //        return TabBarController()
    //    }
    //
    //    func makeNatificationModule() -> NatificationViewController {
    //        return NatificationViewController()
    //    }
    //    func makeBusketModule() -> BusketViewController {
    //        let viewModel = BasketViewModel(basketService: container.basketService)
    //        return BusketViewController(basketViewModel: viewModel)
    //    }
    func makeMainModule() -> MainViewController {
        return MainViewController()
    }
    //
    //    func makeProductModule() -> ProductViewController {
    //        let viewModel = ProductViewModel(service: container.productService)
    //        return ProductViewController(viewModel: viewModel)
    //    }
    //
}

