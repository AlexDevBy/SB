//
//  BaseCoordinator.swift
//  SB
//
//  Created by Alex Misko on 11.01.23.
//


import Foundation

protocol CoordinatorFactoryProtocol {

    func makeApplicationCoordinator(with router: Router) -> AppCoordinator
//    func makeTabBarCoordinator(with router: Router) -> TabBarCoordinator
//
//    func makeNatificationCoordinator(with router: Router) -> NatificationCoordinator
//    func makeBusketCoordinator(with router: Router) -> BusketCoordinator
    func makeMainCoordinator(with router: Router) -> MainCoordinator

    
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {

    private let moduleFactory: ModuleFactoryProtocol
    let serviceAssembly: IServiceAssembly

    init(moduleFactory: ModuleFactoryProtocol,
         serviceAssembly: IServiceAssembly) {
        self.moduleFactory = moduleFactory
        self.serviceAssembly = serviceAssembly
    }

//    func makeMainCoordinator(with router: Router) -> CatalogFoodCoordinator {
//        return CatalogFoodCoordinator(router: router, moduleFactory: moduleFactory)
//    }
//    func makeNatificationCoordinator(with router: Router) -> NatificationCoordinator {
//        return NatificationCoordinator(router: router, moduleFactory: moduleFactory)
//    }
//
//    func makeBusketCoordinator(with router: Router) -> BusketCoordinator {
//        return BusketCoordinator(router: router, moduleFactory: moduleFactory)
//    }
//
    func makeMainCoordinator(with router: Router) -> MainCoordinator {
        return MainCoordinator(router: router, coordinatorFactory: self, moduleFactory: moduleFactory)
    }
    
    
    
    
    func makeApplicationCoordinator(with router: Router) -> AppCoordinator {
        return AppCoordinator(router: router, coordinatorFactory: self, modulesFactory: moduleFactory, serviceAssembly: serviceAssembly)
    }

//    func makeTabBarCoordinator(with router: Router) -> TabBarCoordinator {
//        return TabBarCoordinator(router: router, coordinatorFactory: self)
//    }

}
