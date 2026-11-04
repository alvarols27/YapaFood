//
//  RestaurantListView.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-09.
//

import SwiftUI

struct RestaurantSectionView: View {
    let section: HomeSection
    let restaurants: [Restaurant]

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with subtitle
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(section.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    if restaurants.count > 3 {
                        Text("Ver todo")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                }
                
                if let subtitle = section.subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.leading, 20)
            
            // Horizontal scroll or grid
            if restaurants.isEmpty {
                EmptySectionView(section: section)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(restaurants) { restaurant in
                            RestaurantCard(restaurant: restaurant)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.vertical, 5)
        .enableInjection()
    }
}

struct EmptySectionView: View {
    let section: HomeSection

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 40))
                .foregroundColor(.gray.opacity(0.3))
            
            Text("Pronto tendrás más '\(section.title)'")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
        .padding(.horizontal)
        .enableInjection()
    }
}

//#Preview {
//    let sampleRestaurants = [
//        Restaurant(
//            id: "1",
//            name: "Panadería San Antonio",
//            cuisine: "Panadería Peruana",
//            distance: 0.8,
//            address: "Av. Arequipa 123",
//            image: "",
//            logo: "",
//            pickupStart: "18:00",
//            pickupEnd: "19:30",
//            price: 8.50,
//            rating: 4.7,
//            latitude: nil,
//            longitude: nil,
//            isActive: true,
//            description: "Pan francés y empanadas",
//            category: .bakery,
//            mealTypes: [.breakfast],
//            isNew: false,
//            isPopular: true,
//            lastOnes: true,
//            todaysMostCoveted: false,
//            isFavourite: false
//        ),
//        Restaurant(
//            id: "2",
//            name: "La Picantería",
//            cuisine: "Ceviche",
//            distance: 1.5,
//            address: "Calle Bolívar 456",
//            image: "",
//            logo: "",
//            pickupStart: "20:00",
//            pickupEnd: "21:30",
//            price: 15.90,
//            rating: 4.9,
//            latitude: nil,
//            longitude: nil,
//            isActive: true,
//            description: "Ceviche mixto tradicional",
//            category: .meals,
//            mealTypes: [.lunch, .dinner],
//            isNew: true,
//            isPopular: true,
//            lastOnes: false,
//            todaysMostCoveted: true,
//            isFavourite: false
//        )
//    ]
//    
//    return VStack {
//        RestaurantSectionView(
//            section: .nearest,
//            restaurants: sampleRestaurants
//        )
//        
//        RestaurantSectionView(
//            section: .lastChance,
//            restaurants: []
//        )
//    }
//}
