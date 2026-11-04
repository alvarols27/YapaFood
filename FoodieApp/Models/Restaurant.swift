//
//  Restaurant.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-06.
//

import Foundation
import CoreLocation

enum RestaurantCategory: String, CaseIterable, Codable {
    case meals = "Casero"
    case groceries = "Abarrotes"
    case bakery = "Panadería"
    case international = "Internacional"
}

enum MealType: String, CaseIterable, Codable {
    case breakfast = "Desayuno"
    case lunch = "Almuerzo"
    case dinner = "Cena"
    case snack = "Merienda"
}

struct Restaurant: Identifiable, Codable {
    let id: String
    let name: String
    let cuisine: String
    let distance: Double
    let address: String
    let image: String
    let logo: String
    let pickupStart: String  // "19:00" - 24h format is easier
    let pickupEnd: String    // "20:00"
    let price: Double
    let rating: Double?
    let latitude: Double?
    let longitude: Double?
    let isActive: Bool       // Is restaurant currently offering bags?
    let description: String  // "Today's surprise bag includes..."
    
    //This is for the section in Home page
    let category: RestaurantCategory
    let mealTypes: [MealType]
    let isNew: Bool //For new providers
    let isPopular: Bool
    let lastOnes: Bool
    let todaysMostCoveted: Bool //"Mas pedidos solo por ese dia"
    let isFavourite: Bool
}

extension Restaurant {
    func distanceFrom(_ location: CLLocation?) -> Double {
        guard let location = location,
              let lat = latitude,
              let lon = longitude else {
            return distance
        }
        
        let restaurantLocation = CLLocation(latitude: lat, longitude: lon)
        let distanceInMeters = location.distance(from: restaurantLocation)
        let distanceInKm = distanceInMeters / 1000.0
        return distanceInKm
    }
}
