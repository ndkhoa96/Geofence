//
//  GeoAreaDataModel.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 28/01/2022.
//

import Foundation

struct GeoAreaDataModel: Codable {

    let identifier: String
    let name: String
    let wifiName: String
    let radius: Double
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
      case latitude, longitude, radius, identifier, name, wifiName
    }
    
    init(identifier: String, name: String, wifiName: String, radius: Double, latitude: Double, longitude: Double) {
        self.identifier = identifier
        self.name = name
        self.wifiName = wifiName
        self.radius = radius
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: Codable
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        radius = try values.decode(Double.self, forKey: .radius)
        identifier = try values.decode(String.self, forKey: .identifier)
        name = try values.decode(String.self, forKey: .name)
        wifiName = try values.decode(String.self, forKey: .wifiName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(radius, forKey: .radius)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(name, forKey: .name)
        try container.encode(wifiName, forKey: .wifiName)
    }
}
