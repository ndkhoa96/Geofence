//
//  GeoAreaUI+Mapping.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 28/01/2022.
//

import Foundation

extension GeoAreaEntity {
    func toGeoAreaUI() -> GeoAreaUI {
        GeoAreaUI(name: name,
                  wifiName: wifiName,
                  radius: radius,
                  coordinate: coordinate.toCoordinator2D())
    }
}
extension GeoAreaUI {
    func toGeoAreaEntity() -> GeoAreaEntity {
        GeoAreaEntity(name: name,
                      wifiName: wifiName,
                      radius: radius,
                      coordinate: Coordinate(late: coordinate.latitude,
                                             long: coordinate.longitude))
    }
}
