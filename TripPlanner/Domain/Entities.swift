//
//  Models+Mapping.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 27.01.2024.
//

import CoreLocation

// MARK: - Connection
struct Connection {
    let from: Location
    let to: Location
    let price: Int
    
    init(fromDTO dto: ConnectionDTO) {
        from = Location(title: dto.from,
                        coordinate: CLLocationCoordinate2D.from(DTO: dto.coordinates.from))
        to = Location(title: dto.to,
                      coordinate: CLLocationCoordinate2D.from(DTO: dto.coordinates.to))
        price = dto.price
    }
}

// MARK: - Location
struct Location: Equatable, Hashable, CustomStringConvertible {
    let title: String
    let coordinate: CLLocationCoordinate2D

    var description: String {
        title
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

// MARK: - GeoLocation
extension CLLocationCoordinate2D {
    static func from(DTO dto: GeoLocationDTO) -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: dto.lat, longitude: dto.long)
    }
}
