//
//  AppDelegate.swift
//  SBProject
//
//  Created by Alex Misko on 17.01.23.
//

import UIKit
import UserNotifications
import SafariServices

enum Identifiers {
    static let viewAction = "VIEW_IDENTIFIER"
    static let newsCategory = "NEWS_CATEGORY"
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let rootAssembly = RootAssembly()
    fileprivate var appCoordinator: Coordinatable?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UITabBar.appearance().barTintColor = UIColor(hexString: "#63B7F8")
        UITabBar.appearance().tintColor = UIColor.white
        
        registerForPushNotifications()
        
        let notificationOption = launchOptions?[.remoteNotification]
        
        if
            let notification = notificationOption as? [String: AnyObject],
            let aps = notification["aps"] as? [String: AnyObject] {
            NewsItem.makeNewsItem(aps)
//            (window?.rootViewController as? UITabBarController)?.selectedIndex = 1
            createStartView(window: window ?? UIWindow(frame: UIScreen.main.bounds))
        }
        if #available(iOS 13, *) { }
        else { createStartView(window: window ?? UIWindow(frame: UIScreen.main.bounds)) }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        rootAssembly.serviceAssembly.userInfoService.saveNotificationToken(token: token)
        rootAssembly.serviceAssembly.networkService.sendPushToken(token: token, countryCode: rootAssembly.serviceAssembly.userInfoService.getCountry())
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        NewsItem.makeNewsItem(aps)
        completionHandler(.newData)
    }
    
    private func createStartView(window: UIWindow) {
        let navigationController = UINavigationController()
        let router = Router(rootController: navigationController)
        let moduleFactory = ModuleFactory()
        let serviceAssembly = rootAssembly.serviceAssembly
        let coordinatorFactory = CoordinatorFactory(moduleFactory: moduleFactory, serviceAssembly: serviceAssembly)
        self.appCoordinator = coordinatorFactory.makeApplicationCoordinator(with: router)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.appCoordinator?.start()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
                print("Permission granted: \(granted)")
                guard granted else { return }
                let viewAction = UNNotificationAction(
                    identifier: Identifiers.viewAction,
                    title: "View",
                    options: [.foreground])
                let newsCategory = UNNotificationCategory(
                    identifier: Identifiers.newsCategory,
                    actions: [viewAction],
                    intentIdentifiers: [],
                    options: []
                )
                UNUserNotificationCenter.current().setNotificationCategories([newsCategory])
                self?.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        
        if let aps = userInfo["aps"] as? [String: AnyObject],
           let newsItem = NewsItem.makeNewsItem(aps) {
            createStartView(window: window ?? UIWindow(frame: UIScreen.main.bounds))
            
            if response.actionIdentifier == Identifiers.viewAction,
               let url = URL(string: newsItem.link) {
                let safari = SFSafariViewController(url: url)
                window?.rootViewController?.present(safari, animated: true, completion: nil)
            }
        }
        completionHandler()
    }
}
