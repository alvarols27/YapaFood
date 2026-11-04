//
//  RestaurantCard.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-06.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantCard: View {
    let restaurant: Restaurant
    @State private var selectedRestaurant: Restaurant?

    private var formattedPickupTime: String {
        // Handle both formats: "19:00-21:00" or just "19:00"
        if restaurant.pickupStart.contains("-") {
            return restaurant.pickupStart
        } else if !restaurant.pickupEnd.isEmpty {
            return "\(restaurant.pickupStart)-\(restaurant.pickupEnd)"
        } else {
            return "Hoy \(restaurant.pickupStart)"
        }
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif

    var body: some View {
        Button(action: {
            selectedRestaurant = restaurant
        }) {
            VStack(spacing: 12) {
                // IMAGE HEADER
                ZStack(alignment: .topTrailing) {
                    imageView
                        .frame(width: 280, height: 180)
                        .clipped()
                    
                    // Rating badge
                    if let rating = restaurant.rating {
                        Text("🔥 \(rating, specifier: "%.1f")")
                            .font(.caption.bold())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.ultraThinMaterial)
                            .clipShape(Capsule())
                            .padding(12)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding([.top, .leading, .trailing], 12)
                
                // CONTENT
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(restaurant.name)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Text(restaurant.cuisine)
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.orange.opacity(0.15))
                            .clipShape(Capsule())
                    }
                    
                    // Pickup & distance - FIXED LINE
                    HStack(spacing: 15) {
                        Label(formattedPickupTime, systemImage: "clock")
                        Label("\(restaurant.distance, specifier: "%.1f") km", systemImage: "location.fill")
                    }
                    .font(.caption)
                    .foregroundColor(.primary)
                    
                    // Desc
                    Text(restaurant.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    Divider()
                    
                    // FOOTER
                    HStack {
                        Text("S/. \(String(format: "%.2f", restaurant.price).replacingOccurrences(of: ".", with: ",")) PEN")
                            .font(.title3.bold())
                            .foregroundColor(.green)
                        
                        Spacer()
                    }
                }
                .padding([.leading, .trailing, .bottom], 13)
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.08), radius: 5, y:0)
            )
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
        .fullScreenCover(item: $selectedRestaurant) {
            restaurant in RestaurantDetailView(restaurant: restaurant)
        }
        .enableInjection()
    }

    // MARK: SEPARATE VIEW TO HANDLE IMAGES (imageView, logoView)
    // LOGO
    private var logoView: some View {
        Group {
            if let url = URL(string: restaurant.logo) {
                WebImage(url: url)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: 70, height: 69)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.bottom, 15)
        .padding(.trailing, 15)
    }

    //IMAHE HEADER
    private var imageView: some View {
        Group {
            if let url = URL(string: restaurant.image) {
                WebImage(url: url)
                    .resizable()
                    .scaledToFill()
            }
        }
        .overlay(alignment: .bottomTrailing) {
            logoView
        }
    }
}


#Preview {
    RestaurantCard(
        restaurant: Restaurant(
            id: "1",
            name: "La Esquina",
            cuisine: "Americano",
            distance: 1.2,
            address: "Av. Principal 123",
            image: "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?cs=srgb&dl=pexels-ash-craig-122861-376464.jpg&fm=jpg",
            logo: "https://img.freepik.com/premium-vector/beautiful-unique-logo-design-food-restaurant-company_1287271-53710.jpg?semt=ais_hybrid&w=740&q=80",
            pickupStart: "19:00",
            pickupEnd: "21:00",  // Changed from "20:00" to match format
            price: 5.99,
            rating: 4.6,
            latitude: nil,
            longitude: nil,
            isActive: true,
            description: "Bolsa del día con platos caseros y sabores tradicionales.",
            category: .meals,  // ← ADD THIS
            mealTypes: [.dinner],  // ← ADD THIS
            isNew: false,  // ← ADD THIS
            isPopular: true,  // ← ADD THIS
            lastOnes: false,  // ← ADD THIS
            todaysMostCoveted: true,  // ← ADD THIS
            isFavourite: false  // ← ADD THIS
        )
    )
}
