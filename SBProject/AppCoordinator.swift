//
//  AppCoordinator.swift
//  SBProject
//
//  Created by Alex Misko on 11.01.23.
//

import UIKit
import Combine
import UserNotifications

enum LaunchInstructor {
    case wayVerify
    case webView(String)
    case locationVerify
    case app
    case push
}

final class AppCoordinator: BaseCoordinator {
    
    // MARK: - Private Properties
    
    private let coordinatorFactory: CoordinatorFactory
    private let modulesFactory: ModuleFactoryProtocol
    private let router: Router
    private var launch: LaunchInstructor = .wayVerify
    private let locationService: IDeviceLocationService & DeviceLocationServiceOutput = DeviceLocationService.shared
    private var bag = Set<AnyCancellable>()
    private let center = UNUserNotificationCenter.current()
    
    
    // MARK: - Initialisers
    
    init(
        router: Router,
        coordinatorFactory: CoordinatorFactory,
        modulesFactory: ModuleFactoryProtocol
    ) {
        self.router = router
        self.modulesFactory = modulesFactory
        self.coordinatorFactory = coordinatorFactory
    }
    
    // MARK: - Public Methods
    
    override func start() {
        performFlow()
    }
    
    // MARK: - Private Methods
    private func performFlow() {
        switch launch {
        case .wayVerify:
            performAppWayFlow()
        case .locationVerify:
            if locationService.authStatus == .notDetermined {
                performLocationVerify()
            } else {
                performAppFlow()
            }
        case .webView(let link):
            performWebViewFlow(link: link)
        case .app:
            performAppFlow()
        case .push:
            performPushVerify()
        }
    }
    
    private func performAppWayFlow() {
        let (vc, output) = modulesFactory.makeAppWayLaunch()
        output.appWay = { [weak self] appway in
            self?.launch = appway
            DispatchQueue.main.async {
                self?.performFlow()
            }
        }
        router.setRoot(vc, animated: false)
    }
    
    private func performAppFlow() {
        let tabBarCoordinator = coordinatorFactory.makeMainCoordinator(with: router)
        retain(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
    private func performWebViewFlow(link: String) {
        let webView = WebViewController(site: link, title: "some title", withExitButton: false, withBackButton: false)
        webView.modalPresentationStyle = .fullScreen
        router.setRoot(webView, animated: false)
    }
    
    private func performLocationVerify() {
        locationService.authStatusPublisher
            .sink { [weak self] status in
                switch status {
                case .notDetermined:
//                    self?.performAsk(type: .location)
                    print("notDetermined")
                case .none:
                    break
                case .denied, .authorizedAlways, .restricted, .authorizedWhenInUse:
                    self?.launch = .app
                    self?.performFlow()
                }
            }
            .store(in: &bag)
    }
    
    private func performPushVerify() {
        center.getNotificationSettings(completionHandler: { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .denied, .provisional, .ephemeral:
                    print(".authorized, .denied, .provisional, .ephemeral")
                    self.launch = .app
                    self.performFlow()
                case .notDetermined:
                    print("not determined, ask user for permission now")
                    self.performAsk(type: .push)
                @unknown default:
                    self.launch = .app
                    self.performFlow()
                }
            }
        })
    }
    
    
    private func performAsk(type: PermissionsType) {
        
        let vc = AskPermisionsVS(permissionsType: type)
        self.router.setRoot(vc, animated: false)
        
        vc.skipped = { [weak self] in
            self?.launch = .app
            self?.performFlow()
        }
    }
    
    
}
