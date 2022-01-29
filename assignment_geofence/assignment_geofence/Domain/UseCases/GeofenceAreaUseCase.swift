//
//  AddGeofication.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 27/01/2022.
//

protocol GeofenceAreaUseCase {
    func loadAll(completion: ((Result<[GeoAreaEntity],Error>) -> Void)?)
    func add(radius: Double, name: String, wifiName: String, coordinate: Coordinate, completion: ((Result<Void,Error>) -> Void)?)
    func remove(with identifier: String, completion: ((Result<Void,Error>) -> Void)?)
}

final class GeofenceAreaUseCaseImp: GeofenceAreaUseCase {

    private let repo: GeoficationRepository
    
    init(repo: GeoficationRepository) {
        self.repo = repo
    }
    
    func loadAll(completion: ((Result<[GeoAreaEntity], Error>) -> Void)?) {
        repo.loadAllGeofication(completion: completion)
    }
    
    func add(radius: Double, name: String, wifiName: String, coordinate: Coordinate, completion: ((Result<Void, Error>) -> Void)?) {
        repo.addGeofication(entity: GeoAreaEntity(name: name,
                                                  wifiName: wifiName,
                                                  radius: radius,
                                                  coordinate: coordinate),
                            completion: completion)
    }
    
    func remove(with identifier: String, completion: ((Result<Void, Error>) -> Void)?) {
        repo.removeGeofication(with: identifier, completion: completion)
    }
        
}
