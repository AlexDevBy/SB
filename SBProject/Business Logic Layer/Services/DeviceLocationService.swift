//
//  DeviceLocationService.swift
//  SBProject
//
//  Created by Alex Misko on 14.01.23.
//

import Foundation
import CoreLocation
import Combine

protocol IDeviceLocationService: AnyObject {
    func requestLocationUpdates()
}

protocol DeviceLocationServiceOutput {
    var location: CLLocationCoordinate2D? { get }
    var locationPublisher: AnyPublisher<CLLocationCoordinate2D?, Never> { get }
    var authStatus: CLAuthorizationStatus? { get }
    var authStatusPublisher: AnyPublisher<CLAuthorizationStatus?, Never> { get }
}

final class DeviceLocationService: NSObject, CLLocationManagerDelegate, IDeviceLocationService, DeviceLocationServiceOutput {
    
    static let shared = DeviceLocationService()
    
    private lazy var authSubject: CurrentValueSubject<CLAuthorizationStatus?, Never> = .init(locationManager.authorizationStatus)
    private lazy var locationSubject: CurrentValueSubject<CLLocationCoordinate2D?, Never> = .init(locationManager.location?.coordinate)
    
    // MARK: - DeviceLocationServiceOutput
    
    var locationPublisher: AnyPublisher<CLLocationCoordinate2D?, Never> {
        locationSubject.eraseToAnyPublisher()
    }

    var authStatusPublisher: AnyPublisher<CLAuthorizationStatus?, Never> {
        authSubject.eraseToAnyPublisher()
    }

    var location: CLLocationCoordinate2D? {
        locationSubject.value
    }
    
    
    var authStatus: CLAuthorizationStatus? {
        authSubject.value
    }
    
    
    private override init() {
        super.init()
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    func requestLocationUpdates() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
        authSubject.send(locationManager.authorizationStatus)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
        }
        authSubject.send(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationSubject.send(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: check
    }
}
