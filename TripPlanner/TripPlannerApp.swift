//
//  TripPlannerApp.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 27.01.2024.
//

import SwiftUI

@main
struct TripPlannerApp: App {
    
    let tripManager = TripManager(apiService: ApiService.shared)
    
    var body: some Scene {
        WindowGroup {
            PlannerView(tripManager: tripManager)
        }
    }
}
