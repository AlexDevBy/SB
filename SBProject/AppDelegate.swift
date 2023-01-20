//
//  AppDelegate.swift
//  SBProject
//
//  Created by Alex Misko on 17.01.23.
//


import UIKit
import UserNotifications
//import IronSource

@main
class AppDelegate: UIResponder, UIApplicationDelegate  {
   
    
//    ISInitializationDelegate
    
    

    let conteiner = DIContainer()
    
//    private enum Constants {
//        static let IronAppKey = "184a60125"
//    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        setupFrameworks()
        registerForPushNotifications()
        
        return true
    }

    
//    private func setupFrameworks() {
//        IronSource.initWithAppKey(Constants.IronAppKey, delegate: self)
////        IronSource.setInterstitialDelegate(AppDelegate())
////        IronSource.setRewardedVideoDelegate(AppDelegate())
//        
////        IronSource.initWithAppKey(Constants.IronAppKey, adUnits: [IS_REWARDED_VIDEO])
//    }
//    
//    func initializationDidComplete() {
//        ISIntegrationHelper.validateIntegration()
//    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            // 1. Check to see if permission is granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
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
