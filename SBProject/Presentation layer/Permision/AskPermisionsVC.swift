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
import UserNotifications
import Combine


enum PermissionsType {
    case push
    case location
    
    var title: String {
        switch self {
        case .push:
            return "By enabling push notifications, you will receive updates and alerts from us. This feature ensures that you stay informed about significant news and events, along with exclusive deals and promotions."
        case .location:
            return "Please, allow us to track your location to find reason why we tracking your location. "
        }
    }
}


class AskPermisionsVS: UIViewController, UNUserNotificationCenterDelegate {
    
//    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    let permissionsType: PermissionsType
    let locationManager = CLLocationManager()
    var locationService = DeviceLocationService.shared
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
    
    
   private lazy var allowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Allow", for: .normal)
       button.titleLabel?.font = AppFont.markProFont(ofSize: 18, weight: .bold)
       button.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
       button.backgroundColor = UIColor(hexString: "#262F68")
       button.addTarget(self, action: #selector(allowTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var notNowButton: UIButton = {
         let button = UIButton()
         button.setTitle("Not now", for: .normal)
        button.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "Not now", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.addTarget(self, action: #selector(notNowTapped), for: .touchUpInside)
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
//        ifLocationIsEnabled()
        setupUI()
        
    }
    
    @objc func allowTapped() {
        switch permissionsType {
        case .push:
            getNotificationSettings { [weak self] (success) -> Void in
                if success {
                    self?.skipped?()
                }
            }
        case .location:
            print("location")
//            locationService.requestLocationUpdates()
        }
    }
    
    
    @objc func notNowTapped() {
        switch permissionsType {
        case .push:
            skipped?()
            break
        case .location:
 //           DefaultsManager.isAskedForLocation = true
            skipped?()
            break
        }
    }
    
    func getNotificationSettings(_ completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            // 1. Check to see if permission is granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                completion(true)
            }
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
                    self.notNowTapped()
                @unknown default:
                    break
                }
            } else {
                print("Location services are not enabled")
            }
        }
    }
    
    
    
    

    
    
    func setupUI() {
        view.addSubview(topLabel)
        view.addSubview(permisionText)
        view.addSubview(allowButton)
        view.addSubview(notNowButton)
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(189)
            $0.left.equalTo(view.snp.left).offset(147)
            $0.height.width.equalTo(80)
        }
        
        permisionText.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(52)
            $0.height.equalTo(131)
            $0.width.equalTo(271)
            
        }
        
        allowButton.snp.makeConstraints {
            $0.bottom.equalTo(notNowButton.snp.top).offset(-20)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(271)
        }
        
        notNowButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-120)
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


