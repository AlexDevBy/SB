//
//  SceneDelegate.swift
//  SBProject
//
//  Created by Alex Misko on 10.01.23.
//


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    fileprivate var appCoordinator: Coordinatable?
    
    fileprivate func run() {
        let navigationController = UINavigationController()
        let router = Router(rootController: navigationController)
        let moduleFactory = ModuleFactory()
        let coordinatorFactory = CoordinatorFactory(moduleFactory: moduleFactory)
        self.appCoordinator = coordinatorFactory.makeApplicationCoordinator(with: router)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        self.appCoordinator?.start()
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        run()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}




