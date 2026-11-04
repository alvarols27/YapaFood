//
//  LocationHeaderView.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-09.
//

import SwiftUI
import MapKit

struct LocationHeaderView: View {
    @ObservedObject var locationManager: LocationManager
    @State private var locationName = "Buscando ubicación..."
    @State private var radius = "5 km"
    
    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                // Location icon
                Image(systemName: "location.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 20))
                
                // Location text
                VStack(alignment: .leading, spacing: 2) {
                    Text(locationName)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Dentro de \(radius)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                //MARK: Settings/refresh button (non-functional for now)
                Button(action: {
                    // Will implement location refresh later
                    print("Location refresh tapped")
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.green)
                        .opacity(0.8)
                }
            }
            Divider()
                .padding([.top, .horizontal], 4)
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .background(Color(.systemBackground))
        .onAppear {
            reverseGeocodeLocation()
        }
        .onChange(of: locationManager.currentLocation) {
            oldValue, newValue in reverseGeocodeLocation()
        }
        .enableInjection()
    }
    
    private func reverseGeocodeLocation() {
        guard let location = locationManager.currentLocation else {
            locationName = "Ubicación no disponible"
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                let city = placemark.locality ??
                placemark.administrativeArea ??
                placemark.subAdministrativeArea ??
                "Ubicación actual"
                DispatchQueue.main.async {
                    self.locationName = city
                }
            } else if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.locationName = "Ubicación actual"
                }
            }
        }
    }
}

#Preview {
    LocationHeaderView(locationManager: LocationManager())
}
