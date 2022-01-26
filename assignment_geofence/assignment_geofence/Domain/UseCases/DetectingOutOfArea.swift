//
//  DetectingOutOfArea.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 26/01/2022.
//

import Foundation
import CoreLocation

protocol DetectOutOfArea {
    func execute(device: DeviceInfoEntity, area: GeoAreaEntity) -> Bool
}

final class DetectOutOfAreaImp: DetectOutOfArea {
    func execute(device: DeviceInfoEntity, area: GeoAreaEntity) -> Bool {
        return true
    }

    private let manager: LocationManagerProtocol
    
    init(manager: LocationManagerProtocol) {
        self.manager = manager
    }
}
