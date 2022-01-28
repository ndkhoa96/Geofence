//
//  GeoficationRepository.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 27/01/2022.
//

import Foundation

protocol GeoficationRepository {
    func loadAllGeofication(completion: @escaping (Result<[GeoAreaEntity],Error>) -> Void)
    func addGeofication(entity: GeoAreaEntity, completion: @escaping (Result<Void,Error>) -> Void)
    func removeGeofication(with identifier: String, completion: @escaping (Result<Void,Error>) -> Void)
}
