//
//  GeoAreaEntity+Extension.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 29/01/2022.
//

import CoreLocation

extension GeoAreaEntity {
    var region: CLCircularRegion {
        let region = CLCircularRegion(center: coordinate.toCoordinator2D(),
                                      radius: radius,
                                      identifier: identifier)
        
        region.notifyOnEntry = true
        return region
    }
}
extension Coordinate {
    func toCoordinator2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: late, longitude: long)
    }
}
extension CLLocationCoordinate2D {
    func toCoordinate() -> Coordinate {
        Coordinate(late: latitude, long: longitude)
    }
}
