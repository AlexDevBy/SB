//
//  RootAssembly.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import Foundation

class RootAssembly {
    lazy var coordinatorFactory: CoordinatorFactoryProtocol = CoordinatorFactory(moduleFactory: moduleFactory, serviceAssembly: serviceAssembly)
    lazy var serviceAssembly: IServiceAssembly = ServiceAssembly(coreAssembly: coreAssembly)
    lazy var coreAssembly: ICoreAssembly = CoreAssembly()
    lazy var moduleFactory: ModuleFactoryProtocol = ModuleFactory()
}
