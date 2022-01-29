//
//  GeoficationRepositoryMock.swift
//  assignment_geofenceTests
//
//  Created by Khoa Nguyen on 29/01/2022.
//

@testable import assignment_geofence

class GeoficationRepositoryMock: GeoficationRepository {

    var geoAreaEntities = [GeoAreaEntity]()
    
    func loadAllGeofication(completion: ((Result<[GeoAreaEntity], Error>) -> Void)?) {
        completion?(.success(geoAreaEntities))
    }
    
    func addGeofication(entity: GeoAreaEntity, completion: ((Result<Void, Error>) -> Void)?) {
        geoAreaEntities.append(entity)
        completion?(.success())
    }
    
    func removeGeofication(with identifier: String, completion: ((Result<Void, Error>) -> Void)?) {
        geoAreaEntities.removeAll(where: {$0.identifier == identifier })
        completion?(.success())
    }
    
    
    
}
