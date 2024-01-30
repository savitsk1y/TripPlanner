//
//  TripManager.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 29.01.2024.
//

import Foundation

protocol TripManagerProtocol {
    var locations: [Location] { get }
    func fetchConnections() async throws
    func findRoute(from: Location, to: Location) -> ([Location], Int)?
}

class TripManager: TripManagerProtocol {
    var locations: [Location] {
        let locationsAll = connections.map { $0.from } + connections.map { $0.to }
        return Array(Set(locationsAll)).sorted { $0.title < $1.title }
    }

    private var connections: [Connection] = []
    private let apiService: ApiServiceProtocol

    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchConnections() async throws {
        let result = try await apiService.fetchConnections()
        connections = result.map { Connection(fromDTO: $0) }
    }
    
    // Dijkstra's algorithm implementation
    func findRoute(from: Location, to: Location) -> ([Location], Int)? {
        // Make CostGraph from Connections
        var costGraph: [Location: [Location: Int]] = [:]
        for location in locations {
            var waysCost: [Location: Int] = [:]
            connections.filter { $0.from == location }.forEach {
                waysCost[$0.to] = $0.price
            }
            costGraph[location] = waysCost
        }

        var prices: [Location: Int] = [:]
        var visited = Set<Location>()
        var path = [Location: Location]()
        
        for location in locations {
            if location != from {
                prices[location] = Int.max
            } else {
                prices[from] = 0
            }
        }
        
        while !visited.contains(to) {
            var bestPrice = Int.max
            var node: Location?
            
            for price in prices {
                if bestPrice > price.value && !visited.contains(price.key) {
                    bestPrice = price.value
                    node = price.key
                }
            }
            
            guard let node = node else { return nil }
            let neighbors: [Location: Int] = costGraph[node] ?? [:]
            for neighbor in neighbors {
                let tripCost = (prices[node] ?? 0) + neighbor.value
                if tripCost < prices[neighbor.key] ?? 0 {
                    prices[neighbor.key] = tripCost
                    path[neighbor.key] = node
                }
            }
            visited.insert(node)
        }
                
        var shortPath: [Location] = []
        var current = to
        while current != from {
            shortPath.insert(current, at: 0)
            guard let currentTmp = path[current] else { continue }
            current = currentTmp
        }
        shortPath.insert(from, at: 0)
        
        guard shortPath.count > 1 else { return nil }
        
        var totalPrice = 0
        for index in 0...(shortPath.count - 2) {
            let from = shortPath[index]
            let to = shortPath[index + 1]
            totalPrice += costGraph[from]?[to] ?? 0
        }
        return (shortPath, totalPrice)
    }
}
