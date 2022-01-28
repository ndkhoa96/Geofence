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
    var isMonitoringAvailable: Bool { get }
    func requestAuthorization(_ status: @escaping (AuthorizationStatus) -> Void)
    func startMonitoring(geotification: GeoAreaEntity)
    func stopMonitoring(geotification: GeoAreaEntity)
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
    
    var isMonitoringAvailable: Bool {
        return CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self)
    }
    
    func startMonitoring(geotification: GeoAreaEntity) {
        if !isMonitoringAvailable {
            return
        }
        
        let fenceRegion = geotification.region
        manager.startMonitoring(for: fenceRegion)
    }
    
    func stopMonitoring(geotification: GeoAreaEntity) {
        for region in manager.monitoredRegions {
            guard
                let circularRegion = region as? CLCircularRegion,
                circularRegion.identifier == geotification.identifier
            else { continue }
            manager.stopMonitoring(for: circularRegion)
        }
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
