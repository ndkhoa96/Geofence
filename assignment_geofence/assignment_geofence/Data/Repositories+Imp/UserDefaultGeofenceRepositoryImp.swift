//
//  GeoficationRepositoryImp.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 27/01/2022.
//

import Foundation

final class UserDefaultGeofenceRepositoryImp: GeoficationRepository {
    
    private lazy var userDefaults = UserDefaults.standard
    
    private enum PreferencesKeys: String {
        case savedItems
    }
    
    private var geoAreaEntities = [GeoAreaEntity]()
    
    func loadAllGeofication(completion: ((Result<[GeoAreaEntity], Error>) -> Void)?) {
        guard let savedData = userDefaults.data(forKey: PreferencesKeys.savedItems.rawValue)
        else {
            completion?(.success([]))
            return
        }
        let decoder = JSONDecoder()
        do {
            let savedGeotifications = try decoder.decode(Array.self, from: savedData) as [GeoAreaDataModel]
            geoAreaEntities = savedGeotifications.map({ $0.toGeoAreaEntity() })
            completion?(.success(geoAreaEntities))
        } catch let err {
            completion?(.failure(err))
        }
    }
    
    func addGeofication(entity: GeoAreaEntity, completion: ((Result<Void, Error>) -> Void)?) {
        geoAreaEntities.append(entity)
        let models = geoAreaEntities.map({ $0.toGeoAreaDataModel() })
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(models)
            userDefaults.set(data, forKey: PreferencesKeys.savedItems.rawValue)
            completion?(.success())
        } catch let err {
            completion?(.failure(err))
        }
    }
    
    func removeGeofication(with identifier: String, completion: ((Result<Void, Error>) -> Void)?) {
        geoAreaEntities.removeAll(where: {$0.identifier == identifier })
        let models = geoAreaEntities.map({ $0.toGeoAreaDataModel() })
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(models)
            userDefaults.set(data, forKey: PreferencesKeys.savedItems.rawValue)
            completion?(.success())
        } catch let err {
            completion?(.failure(err))
        }
    }
}
