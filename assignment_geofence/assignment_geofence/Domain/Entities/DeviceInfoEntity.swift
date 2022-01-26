//
//  DeviceInfoEntity.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 26/01/2022.
//

import Foundation

enum InRangeStatus {
    case inside
    case outside
}

struct DeviceInfoEntity {
    let identifier: String
    let name: String
    let status: InRangeStatus
    var location: Coordinate
}
