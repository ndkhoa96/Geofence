//
//  GeofenceTests.swift
//  assignment_geofenceTests
//
//  Created by Khoa Nguyen on 27/01/2022.
//

import XCTest
@testable import assignment_geofence

class GeofenceTest: XCTestCase {

    func test_current_location_is_inside_area_geographically() {
        // given
        let model = GeoAreaEntity(name: "L1", wifiName: "khoanguyen", radius: 1000,
                                  coordinate: Coordinate(late: 100, long: 100))
        // when
        let currenCoordinate = Coordinate(late: 100.001, long: 100.001)
        // then
        XCTAssertTrue(model.isInsideArea(currenCoordinate))
    }
    
    func test_current_location_is_not_inside_area_geographically() {
        // given
        let model = GeoAreaEntity(name: "L1", wifiName: "khoanguyen", radius: 1000,
                                  coordinate: Coordinate(late: 100, long: 100))
        // when
        let currenCoordinate = Coordinate(late: 100.01, long: 100.01)
        // then
        XCTAssertFalse(model.isInsideArea(currenCoordinate))
    }
    
    func test_current_location_marked_inside_area_when_wifi_is_connected() {
        // given
        let model = GeoAreaEntity(name: "L1", wifiName: "khoanguyen", radius: 1000,
                                  coordinate: Coordinate(late: 100, long: 100))
        let currenCoordinate = Coordinate(late: 100.001, long: 100.001)
        // when
        model.isWifiConnected = true
        // then
        XCTAssertTrue(model.isInsideArea(currenCoordinate))
    }
    
    func test_current_location_is_marked_outside_area_when_wifi_is_disconnected_and_outside_the_area() {
        // given
        let model = GeoAreaEntity(name: "L1", wifiName: "khoanguyen", radius: 1000,
                                  coordinate: Coordinate(late: 100, long: 100))
        // when
        model.isWifiConnected = false
            let currenCoordinate = Coordinate(late: 100.01, long: 100.01)
        // then
        XCTAssertFalse(model.isInsideArea(currenCoordinate))
    }
}
