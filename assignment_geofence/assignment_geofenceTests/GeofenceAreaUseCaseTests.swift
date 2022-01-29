//
//  GeofenceAreaUseCaseTests.swift
//  assignment_geofenceTests
//
//  Created by Khoa Nguyen on 29/01/2022.
//

import XCTest
@testable import assignment_geofence

class GeofenceAreaUseCaseTests: XCTestCase {
    
    private var geofenceAreaUseCase: GeofenceAreaUseCase!
    private var repo: GeoficationRepositoryMock!

    override func setUp() {
        super.setUp()
        repo = GeoficationRepositoryMock()
        geofenceAreaUseCase = GeofenceAreaUseCaseImp(repo: repo)
    }
    
    override func tearDown() {
        super.tearDown()
        repo = nil
        geofenceAreaUseCase = nil
    }
    
    func test_remove_geo_area() {
        // given
        repo.geoAreaEntities = [GeoAreaEntity(identifier: "1234", name: "", wifiName: "", radius: 100, coordinate: .init(late: 10, long: 10))]
        // when
        geofenceAreaUseCase.remove(with: "1234", completion: nil)
        // then
        geofenceAreaUseCase.loadAll { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 0)
            case .failure(_): break
            }
        }
    }
    
    func test_add_geo_area() {
        // when
        geofenceAreaUseCase.add(radius: 10000, name: "google", wifiName: "wifi",
                                coordinate: .init(late: 100, long: 100), completion: nil)
        
        // then
        geofenceAreaUseCase.loadAll { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 1)
            case .failure(_): break
            }
        }
    }
    
    func test_load_all_saved_geo_area() {
        // given
        repo.geoAreaEntities = [GeoAreaEntity(identifier: "1234", name: "", wifiName: "", radius: 100, coordinate: .init(late: 10, long: 10)),
                                GeoAreaEntity(identifier: "4567", name: "", wifiName: "", radius: 100, coordinate: .init(late: 10, long: 10))]
        // then
        geofenceAreaUseCase.loadAll { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 2)
            case .failure(_): break
            }
        }
    }
    
    
}

