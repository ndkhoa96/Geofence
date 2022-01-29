//
//  LocationManager.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 26/01/2022.
//

import Foundation
import CoreLocation
import UIKit

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
    func onEnterGeoArea(_ completion: @escaping (GeoAreaEntity) -> Void)
}
final class LocationManager: NSObject, LocationManagerProtocol {

    private let manager = CLLocationManager()
    private var authorizeCallback: ((AuthorizationStatus)-> Void)?
    private var onEnterGeoAreaCallback: ((GeoAreaEntity) -> Void)?
    private var monitoringEntities = [GeoAreaEntity]()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorization(_ status: @escaping (AuthorizationStatus) -> Void) {
        authorizeCallback = status
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
        monitoringEntities.append(geotification)
    }
    
    func stopMonitoring(geotification: GeoAreaEntity) {
        for region in manager.monitoredRegions {
            guard
                let circularRegion = region as? CLCircularRegion,
                circularRegion.identifier == geotification.identifier
            else { continue }
            manager.stopMonitoring(for: circularRegion)
            monitoringEntities.removeAll(where: {$0.identifier == geotification.identifier })
        }
    }
    
    func onEnterGeoArea(_ completion: @escaping (GeoAreaEntity) -> Void) {
        onEnterGeoAreaCallback = completion
    }
    
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            authorizeCallback?(.inUse)
        case .authorizedAlways:
            authorizeCallback?(.always)
        case .denied:
            authorizeCallback?(.denied)
        default: break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            if let matched = monitoringEntities.first(where: { $0.identifier == region.identifier }) {
                onEnterGeoAreaCallback?(matched)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        guard let region = region else {
            print("Monitoring failed for unknown region")
            return
        }
        print("Monitoring failed for region with identifier: \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with the following error: \(error)")
    }
}
