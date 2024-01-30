//
//  TripPlannerTests.swift
//  TripPlannerTests
//
//  Created by Andrew Savitskiy on 27.01.2024.
//

import XCTest
@testable import TripPlanner

final class TripPlannerTests: XCTestCase {

    var apiService: ApiServiceProtocol!
    var tripManager: TripManagerProtocol!
    
    override func setUp() {
        super.setUp()
        apiService = ApiService.shared
        tripManager = TripManager(apiService: FakeApiService.shared)
    }
    
    override func tearDown() {
        apiService = nil
        tripManager = nil
        super.tearDown()
    }
   
    func testConnectionsLoadedFromServer() async throws {
        let connections = try await apiService.fetchConnections()
        XCTAssertTrue(connections.count > 0)
    }
    
    func testLoadLocationsFindRoutes() async {
        try? await tripManager.fetchConnections()
        let locations = tripManager.locations
        XCTAssertTrue(locations.count > 0)
        
        let route = tripManager.findRoute(from: locations.first!, to: locations.last!)
        XCTAssertEqual(route!.1, 1020)
    }

}
