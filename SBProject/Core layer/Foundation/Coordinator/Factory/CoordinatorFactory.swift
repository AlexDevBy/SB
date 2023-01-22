//
//  BaseCoordinator.swift
//  SBProject
//
//  Created by Alex Misko on 11.01.23.
//


import Foundation

protocol CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(with router: Router) -> AppCoordinator
    func makeMainCoordinator(with router: Router) -> MainCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {

    private let moduleFactory: ModuleFactoryProtocol

    init(moduleFactory: ModuleFactoryProtocol) {
        self.moduleFactory = moduleFactory
    }

    func makeApplicationCoordinator(with router: Router) -> AppCoordinator {
        return AppCoordinator(router: router, coordinatorFactory: self, modulesFactory: moduleFactory)
    }
    
    func makeMainCoordinator(with router: Router) -> MainCoordinator {
        return MainCoordinator(router: router, coordinatorFactory: self, moduleFactory: moduleFactory)
    }

}
