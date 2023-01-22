//
//  BaseCoordinator.swift
//  SB
//
//  Created by Alex Misko on 11.01.23.
//

import UIKit

protocol Routable {

    func present(_ viewController: UIViewController, animated: Bool)
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func dismiss(animated: Bool)
    func setRoot(_ viewController: UIViewController, animated: Bool)
    func setRoot(_ viewController: UIViewController, animated: Bool, hideBar: Bool)
    func setRootMainThread(_ viewController: UIViewController, animated: Bool)
}

final class Router: Routable {

    private weak var rootNavigationController: UINavigationController?

    init(rootController: UINavigationController) {
        self.rootNavigationController = rootController
    }

    func present(_ viewController: UIViewController, animated: Bool = true) {
        rootNavigationController?.present(viewController, animated: animated, completion: nil)
    }

    func push(_ viewController: UIViewController, animated: Bool = true) {
        rootNavigationController?.pushViewController(viewController, animated: true)
    }

    func pop(animated: Bool) {
        rootNavigationController?.popViewController(animated: true)
    }

    func dismiss(animated: Bool) {
        rootNavigationController?.dismiss(animated: true, completion: nil)
    }

    func setRoot(_ viewController: UIViewController, animated: Bool) {
        setRoot(viewController, animated: animated, hideBar: false)
    }

    func setRoot(_ viewController: UIViewController, animated: Bool, hideBar: Bool) {
        rootNavigationController?.setViewControllers([viewController], animated: animated)
        rootNavigationController?.isNavigationBarHidden = hideBar
    }
    
    func setRootMainThread(_ viewController: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.setRoot(viewController, animated: animated, hideBar: false)
        }
    }
}

