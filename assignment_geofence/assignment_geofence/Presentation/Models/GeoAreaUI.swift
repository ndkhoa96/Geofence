//
//  GeoAreaUI.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 26/01/2022.
//

import MapKit

class GeoAreaUI: NSObject, MKAnnotation {

    let wifiName: String
    let radius: Double
    let coordinate: CLLocationCoordinate2D
    let identifier: String
    
    var title: String? {
        return "WifiName: " + wifiName
    }
    
    init(wifiName: String, radius: Double, coordinate: CLLocationCoordinate2D, identifier: String) {
        self.wifiName = wifiName
        self.radius = radius
        self.coordinate = coordinate
        self.identifier = identifier
    }
    
}
