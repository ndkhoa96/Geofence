//
//  GeoAreaEntity.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 25/01/2022.
//
import CoreLocation

class GeoAreaEntity {
    let wifiName: String
    let radius: Double
    let coordinate: Coordinate
    let identifier: String
    
    init(identifier: String = UUID().uuidString, wifiName: String, radius: Double, coordinate: Coordinate) {
        self.identifier = identifier
        self.wifiName = wifiName
        self.radius = radius
        self.coordinate = coordinate
    }
    
    var isConnectedWifi: Bool = false
}

struct Coordinate {
    let long: Double
    let late: Double
}

// MARK: - Notification Region
extension GeoAreaEntity {

  var region: CLCircularRegion {
    let region = CLCircularRegion(center: coordinate.toCoordinator2D(),
                                  radius: radius,
                                  identifier: identifier)

    region.notifyOnEntry = isConnectedWifi
    region.notifyOnExit = isConnectedWifi == false
    return region
  }
}
extension Coordinate {
    func toCoordinator2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: late, longitude: long)
    }
}