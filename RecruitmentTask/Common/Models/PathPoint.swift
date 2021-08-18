//
//  PathPoint.swift
//  RecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation

struct PathPoint: Equatable, Hashable {
    let timestamp: Int
    let latitude: Double
    let longitude: Double
    let altitude: Double
    let distance: Double
    let accuracy: Double
}

extension PathPoint: Codable {
    enum CodingKeys: String, CodingKey {
        case timestamp
        case longitude
        case latitude
        case altitude
        case distance
        case accuracy
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try values.decode(String.self, forKey: .timestamp).asInt()
        self.latitude = try values.decode(String.self, forKey: .latitude).asDouble()
        self.longitude = try values.decode(String.self, forKey: .longitude).asDouble()
        self.altitude = try values.decode(String.self, forKey: .altitude).asDouble()
        self.distance = try values.decode(String.self, forKey: .distance).asDouble()
        self.accuracy = try values.decode(String.self, forKey: .accuracy).asDouble()
    }
}
