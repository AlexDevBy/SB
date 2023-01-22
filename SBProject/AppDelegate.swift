//
//  AppDelegate.swift
//  SBProject
//
//  Created by Alex Misko on 17.01.23.
//


import UIKit
import UserNotifications
import IronSource

@main
class AppDelegate: UIResponder, UIApplicationDelegate, ISInitializationDelegate, UNUserNotificationCenterDelegate  {
    
    
    let conteiner = DIContainer()
    
    private enum Constants {
        static let IronAppKey = "1852f50bd"
    }
    
    private func setupFrameworks() {
        IronSource.initWithAppKey(Constants.IronAppKey, delegate: self)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFrameworks()
        return true
    }

    func initializationDidComplete() {
        ISIntegrationHelper.validateIntegration()
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
        conteiner.countryService.getCountry { result in
            switch result {
            case .success(let city):
                print(city.data.countryCode)
                let myCity = city.data.countryCode
                self.conteiner.helperService.sendPushToken(token: token, country: myCity ) { result in
                    print(result)
                }
            case .failure(let error):
                print(error)
            }
        }
        print(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
}
