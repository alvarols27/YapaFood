//
//  User.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-06.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let name: String?
    let favoriteCuisines: [String]?  // Optional for future features
    let createdAt: Date
}

