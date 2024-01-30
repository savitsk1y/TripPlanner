//
//  PlannerViewModel.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 27.01.2024.
//

import SwiftUI
import CoreLocation

extension PlannerView {
    @Observable
    class ViewModel {
        var locationList: [Location] = []
        var locationFrom: Location?
        var locationTo: Location?
        var route: ([Location], Int)?
        var lineCoordinates: [CLLocationCoordinate2D] = []
        var searchRequest: String = "" {
            didSet {
                let request = searchRequest.trimmingCharacters(in: .whitespacesAndNewlines)
                if !request.isEmpty {
                    locationList = allLocations.filter { $0.title.lowercased().contains(request.lowercased()) }
                } else {
                    locationList = allLocations
                }
            }
        }
        
        private var allLocations: [Location] = []
        private let tripManager: TripManagerProtocol

        init(tripManager: TripManagerProtocol) {
            self.tripManager = tripManager
        }
        
        func loadData() async {
            do {
                try await tripManager.fetchConnections()
                allLocations = tripManager.locations
                await MainActor.run {
                    locationList = allLocations
                }
            } catch {
                print("Error: \(error)")
            }
        }
        
        func selected(from location: Location) {
            locationFrom = location
            findRoute()
        }
        
        func selected(to location: Location) {
            locationTo = location
            findRoute()
        }
        
        private func findRoute() {
            guard let from = locationFrom,
                  let to = locationTo,
                  let (route, price) = tripManager.findRoute(from: from, to: to) else {
                self.route = nil
                self.lineCoordinates = []
                return
            }
            self.route = (route, price)
            self.lineCoordinates = route.map { $0.coordinate }
        }
    }

}
