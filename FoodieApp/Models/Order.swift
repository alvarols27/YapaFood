//
//  Order.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-06.
//

import Foundation

struct Order: Identifiable, Codable {
    let id: String
    let userId: String
    let restaurantId: String
    let restaurantName: String  // Denormalized for easier display
    let pickupTime: String      // "7:00 PM - 8:00 PM"
    let totalPrice: Double
    let status: OrderStatus     // .pending, .confirmed, .pickedUp, .cancelled
    let createdAt: Date
    let qrCode: String?         // For pickup verification
}

enum OrderStatus: String, Codable {
    case pending, confirmed, ready, pickedUp, cancelled
}
