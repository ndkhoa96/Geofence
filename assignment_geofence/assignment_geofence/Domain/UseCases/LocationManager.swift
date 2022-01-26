//
//  LocationManager.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 26/01/2022.
//

import Foundation
import CoreLocation

enum AuthorizationStatus {
    case always
    case inUse
    case denied
}

protocol LocationManagerProtocol {
    func requestAuthorization(_ status: @escaping (AuthorizationStatus) -> Void)
}
final class LocationManager: NSObject, LocationManagerProtocol {
    
    private let manager = CLLocationManager()
    private var callback: ((AuthorizationStatus)-> Void)?

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorization(_ status: @escaping (AuthorizationStatus) -> Void) {
        callback = status
        manager.requestAlwaysAuthorization()
    }
    
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            callback?(.inUse)
        case .authorizedAlways:
            callback?(.always)
        case .denied:
            callback?(.denied)
        default: break
        }
        
    }
}