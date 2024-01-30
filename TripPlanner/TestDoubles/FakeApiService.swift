//
//  FakeApiService.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 30.01.2024.
//

import Foundation

class FakeApiService: ApiServiceProtocol {
    static let shared = FakeApiService()
    
    private init() {}
    
    func fetchConnections() async throws -> [ConnectionDTO] {
        ConnectionsResponse.fake
    }
    
}
