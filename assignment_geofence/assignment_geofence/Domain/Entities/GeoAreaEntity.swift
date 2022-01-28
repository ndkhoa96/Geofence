//
//  GeoAreaEntity.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 25/01/2022.
//
import CoreLocation

class GeoAreaEntity {
    let name: String
    let wifiName: String
    let radius: Double
    let coordinate: Coordinate
    let identifier: String
    
    init(identifier: String = UUID().uuidString, name: String, wifiName: String, radius: Double, coordinate: Coordinate) {
        self.identifier = identifier
        self.name = name
        self.wifiName = wifiName
        self.radius = radius
        self.coordinate = coordinate
    }
    
    var isWifiConnected: Bool = false
    
    func isInsideArea(_ coordinate: Coordinate) -> Bool {
        region.contains(coordinate.toCoordinator2D()) || isWifiConnected
    }
}

struct Coordinate {
    let late: Double
    let long: Double
}

// MARK: - Notification Region
extension GeoAreaEntity {
    var region: CLCircularRegion {
        let region = CLCircularRegion(center: coordinate.toCoordinator2D(),
                                      radius: radius,
                                      identifier: identifier)
        
        region.notifyOnEntry = isWifiConnected
        region.notifyOnExit = isWifiConnected == false
        return region
    }
}
extension Coordinate {
    func toCoordinator2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: late, longitude: long)
    }
}
