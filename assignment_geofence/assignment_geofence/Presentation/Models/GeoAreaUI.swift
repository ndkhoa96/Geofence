//
//  GeoAreaUI.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 26/01/2022.
//

import MapKit

final class GeoAreaUI: NSObject, MKAnnotation {
    let name: String
    let wifiName: String
    let radius: Double
    let coordinate: CLLocationCoordinate2D
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return "Wifi: " + wifiName
    }
    
    init(name: String, wifiName: String, radius: Double, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.wifiName = wifiName
        self.radius = radius
        self.coordinate = coordinate
    }
    
}
