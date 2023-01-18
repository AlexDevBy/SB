//
//  AppLaunchWayViewController.swift
//  Pixpot
//
//  Created by Vladimir on 16.01.2023.
//

import UIKit

class AppLaunchWayViewController: UIViewController, UNUserNotificationCenterDelegate {

    let viewModel: AppLaunchWayViewModelProtocol

    // MARK: - Init
    init(viewModel: AppLaunchWayViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fetchData()
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo

        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")

            case "show":
                // the user tapped our "show more info…" button
                print("Show more information…")

            default:
                break
            }
        }

        // you must call the completion handler when you're done
        completionHandler()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(hexString: "#63B7F8")
        // TODO: MAKE Launcher
    }
}
