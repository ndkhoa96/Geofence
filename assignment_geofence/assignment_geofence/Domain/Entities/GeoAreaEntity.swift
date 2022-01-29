//
//  GeoAreaEntity.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 25/01/2022.
//
import Foundation

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

