//
//  MainCoordinator.swift
//  SBProject
//
//  Created by Alex Misko on 11.01.23.
//

import UIKit
import SnapKit


final class MainCoordinator: BaseCoordinator {
    
    // MARK: - Private Properties
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private let moduleFactory: ModuleFactoryProtocol
    
    // MARK: - Initialisers
    
    init(router: Router, coordinatorFactory: CoordinatorFactory, moduleFactory: ModuleFactoryProtocol ) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    // MARK: - Public Methods
    
    override func start() {
        showMainScreen()
    }
    
    private func showMainScreen() {
        let page = moduleFactory.makeMainModule()
        page.modalPresentationStyle = .fullScreen
        self.router.setRoot(page, animated: false)
        
    }
}
