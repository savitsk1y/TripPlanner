//
//  MapView.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 29.01.2024.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var lineCoordinates: [CLLocationCoordinate2D]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if let overlay = view.overlays.first {
            view.removeOverlay(overlay)
        }
        let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
        view.addOverlay(polyline)
        
        if let center = lineCoordinates.first {
            view.setCenter(center, animated: true)
            let regionRadius: CLLocationDistance = 10000000
            let coordinateRegion = MKCoordinateRegion(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            view.setRegion(coordinateRegion, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let routePolyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: routePolyline)
                renderer.strokeColor = UIColor(named: "AccentColor")
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }

    }

}
