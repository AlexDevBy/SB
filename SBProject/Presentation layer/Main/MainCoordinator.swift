//
//  MainCoordinator.swift
//  SB
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
//    private var launch: LaunchInstructor = .countryVerify
//    private lazy var container = DIContainer()

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
        
//        page.showQuestionVS = {
//            let questionVC = QuestionViewControlle()
//            self.router.push(questionVC)
//            
//            questionVC.beginTapped1 = { data in
//                self.router.dismiss(animated: false)
//                self.show3()
//            }
//        }
        
    }
    
    
    
//    func show3() {
//        let finalVC = FinalViewController()
//        self.router.push(finalVC)
//
//    }
    // MARK: - Private Methods
//    private func askPermisions() {
//        var type: PermissionsType
//        type = .location
//
//        let vc = AskPermisionsVS(permissionsType: type)
//        self.router.setRoot(vc, animated: false)
//
//        vc.skipped = {
//            self.showMainScreen()
//        }
//    }
    
//    private func showLoadingScreen() {
//
//        //        let loadingPage = moduleFactory.makeLoadingModule()
//        //        self.router.present(loadingPage, animated: true)
//        let viewmodel = CountrySelector(service: container.countryService)
//
//        viewmodel.appWay = { [weak self] appWay , link in
//            guard let self = self else {return}
//            switch appWay {
//            case.webView:
//                DispatchQueue.main.async {
//                    self.showWebScreen(link: link)
//                }
//            case.app:
//                self.showMainScreen()
//            default:
//                break
//            }
//
//        }
//    }
    
    
    
    
//    private func showWebScreen(link: String) {
//
//        let webView = WebViewController(site: link, title: "some title", withExitButton: false, withBackButton: false)
//        webView.modalPresentationStyle = .fullScreen
//        self.router.setRoot(webView, animated: false)
////        self.router.present(webView, animated: false)
//         }

    // MARK: -
}
