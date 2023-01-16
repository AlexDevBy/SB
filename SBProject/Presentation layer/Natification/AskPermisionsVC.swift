//
//  BaseCoordinator.swift
//  SB
//
//  Created by Alex Misko on 11.01.23.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation
import NotificationCenter
import Combine

enum PermissionsType {
    case push
    case location
    
    var title: String {
        switch self {
        case .push:
            return "Please, allow us to send you push-notifications for reminders."
        case .location:
            return "Please, allow us to track your location to find the most relevant sports facilities. "
        }
    }
}


class AskPermisionsVS: UIViewController{
    
    
    let permissionsType: PermissionsType
    private let locationManager = CLLocationManager()
    var locationService = DeviceLocationService.shared
    private let getLink = PassthroughSubject<String, Never>()
    
    var skipped: (() -> Void)?
    
    private lazy var topLabel: UIImageView = {
        let label = UIImageView()
        label.image = UIImage(named: "sb1")
        return label
    }()
    
    
    private lazy var permisionText: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "By enabling push notifications, you will receive updates and alerts from us. This feature ensures that you stay informed about significant news and events, along with exclusive deals and promotions."
        return label
    }()
    
    
   private lazy var askButton: UIButton = {
        let button = UIButton()
        button.setTitle("Allow", for: .normal)
//       button.setTitleColor(AppColors.white, for: .normal)
       button.backgroundColor = UIColor(hexString: "#262F68")
       button.addTarget(self, action: #selector(allowTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var skipButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Not now", for: .normal)
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
         return button
     }()
    
    
    
    
    
    init(permissionsType: PermissionsType) {
        self.permissionsType = permissionsType
        super.init(nibName: nil, bundle: nil)
        
//        self.permisionText.text = permissionsType.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#63B7F8")
        setupUI()
//        ifLocationIsEnabled()

//        DispatchQueue.main.asyncAfter(deadline: .now() ) {
//            let long = self.locationService.currentLocation?.longitude
//            print(long ?? "333")
//        }
        
    }
    
    @objc func skipTapped() {
        switch permissionsType {
        case .push:
            break
        case .location:
 //           DefaultsManager.isAskedForLocation = true
            skipped?()
            break
            
        }
        
    }
    
    func ifLocationIsEnabled(){
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {return}
            if CLLocationManager.locationServicesEnabled() {
                switch self.locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                case .authorizedAlways, .authorizedWhenInUse:
                    self.skipTapped()
                @unknown default:
                    break
                }
            } else {
                print("Location services are not enabled")
            }
        }
    }
    
//    func linkRequest() {
//            let url = URL(string: "https://pixpot.host/user/auth.json")!
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data, error == nil else { return }
//                do {
//                    let links = try JSONDecoder().decode([Link].self, from: data)
//                    for link in links {
//                        self.getLink.send(link.link)
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//            task.resume()
//        }

    
    @objc
    func allowTapped() {
        switch permissionsType {
        case .push:
//            registerForPushNotifications() {
//                self.userInfoService.changeAskPushValue()
//                DispatchQueue.main.async {
//                    self.skipTapped()
//                }
//            }
            break
        case .location:
            locationService.requestLocationUpdates()
        }
    }
    
//    private func registerForPushNotifications(completionHandler: @escaping () -> Void) {
//      UNUserNotificationCenter.current()
//        .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
//            completionHandler()
//            guard granted else { return }
//            self?.getNotificationSettings()
//        }
//    }
//
//    private func getNotificationSettings() {
//      UNUserNotificationCenter.current().getNotificationSettings { settings in
//        print("Notification settings: \(settings)")
//          guard settings.authorizationStatus == .authorized else { return }
//          DispatchQueue.main.async {
//            UIApplication.shared.registerForRemoteNotifications()
//          }
//      }
//    }
  
    
    
    
    func setupUI() {
        view.addSubview(topLabel)
        view.addSubview(permisionText)
        view.addSubview(askButton)
        view.addSubview(skipButton)
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(203)
            $0.left.equalTo(view.snp.left).offset(147)
            $0.height.width.equalTo(80)
        }
        
        permisionText.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(52)
            $0.left.equalToSuperview().offset(52)
            $0.height.equalTo(131)
            $0.width.equalTo(271)
            
        }
        
        askButton.snp.makeConstraints {
            $0.bottom.equalTo(skipButton.snp.top).offset(-20)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.height.equalTo(50)
        }
        
        skipButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-150)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
    }
}

//MARK: DeviceLocationServiceDelegate

//extension AskPermisionsVS: DeviceLocationServiceDelegate {
//    
//    func didChangeLocationStatus() {
//        switch self.locationService.locationStatus {
//        case .authorizedWhenInUse, .authorizedAlways, .denied:
//            skipTapped()
//        default:
//            break
//        }
//    }
//    
//    func loacationDidChange(location: CLLocationCoordinate2D?) {
//        
//        return
//    }
//}
