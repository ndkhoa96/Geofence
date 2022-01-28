//
//  GeoAreaEntity+Mapping.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 28/01/2022.
//

import Foundation

extension GeoAreaEntity {
    func toGeoAreaDataModel() -> GeoAreaDataModel {
        GeoAreaDataModel(identifier: identifier,
                         name: name,
                         wifiName: wifiName,
                         radius: radius,
                         latitude: coordinate.late,
                         longitude: coordinate.long)
    }
}
extension GeoAreaDataModel {
    func toGeoAreaEntity() -> GeoAreaEntity {
        GeoAreaEntity(identifier: identifier,
                         name: name,
                         wifiName: wifiName,
                         radius: radius,
                         coordinate: Coordinate(late: latitude,
                                                long: longitude))
    }
}
