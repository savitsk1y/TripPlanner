//
//  ApiService.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 27.01.2024.
//

import Foundation

protocol ApiServiceProtocol {
    func fetchConnections() async throws -> [ConnectionDTO]
}

class ApiService: ApiServiceProtocol {
    static let shared = ApiService()
    
    private init() {}
    
    func fetchConnections() async throws -> [ConnectionDTO] {
        let url = URL(string: AppConfig.URL.connections)
        let request = URLRequest(url: url!)
        let (data, _) = try await URLSession.shared.data(for: request)
        let fetchedData = try JSONDecoder().decode(ConnectionsResponse.self, from: data)
        return fetchedData.connections
    }
    
}
