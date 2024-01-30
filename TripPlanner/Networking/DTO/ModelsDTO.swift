//
//  ModelsDTO.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 27.01.2024.
//

import Foundation

// MARK: - ConnectionsResponse
struct ConnectionsResponse: Codable {
    let connections: [ConnectionDTO]
}

// MARK: - Connection
struct ConnectionDTO: Codable {
    let from, to: String // City name
    let coordinates: CoordinatesDTO
    let price: Int
}

// MARK: - Coordinates
struct CoordinatesDTO: Codable {
    let from, to: GeoLocationDTO
}

// MARK: - GeoLocation
struct GeoLocationDTO: Codable {
    let lat, long: Double
}
