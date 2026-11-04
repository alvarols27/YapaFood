//
//  HomeSection.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-09.
//

import Foundation

enum HomeSection: CaseIterable, Identifiable {
    case nearest
    case lastChance
    case new
    case meals
    case breakfast
    case localSpecialties
    case groceries
    case popularToday
    
    var id: String { title }
    
    var title: String {
        switch self {
        case .nearest: return "📍 Más Cercanos"
        case .lastChance: return "⏰ Se Acaba Hoy"
        case .new: return "✨ Nuevos Socios"
        case .meals: return "🍛 Comida Casera"
        case .breakfast: return "☕ Desayunos"
        case .localSpecialties: return "🌮 Especialidades"
        case .groceries: return "🛒 Abarrotes"
        case .popularToday: return "🏆 Más Reservados"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .nearest: return "Recoge en menos de 15 min"
        case .lastChance: return "Últimas bolsas disponibles"
        case .new: return "Restaurantes recién unidos"
        case .meals: return "Platos del día"
        case .breakfast: return "Panaderías & cafés"
        case .localSpecialties: return "Sabores de la región"
        case .groceries: return "Frutas y verduras frescas"
        case .popularToday: return "Los favoritos de hoy"
        }
    }
}

extension HomeSection {
    func restaurants(from all: [Restaurant]) -> [Restaurant] {
        switch self {
        case .nearest:
            return all
                .filter { $0.distance < 5 } // 5km radius for LATAM cities
                .sorted { $0.distance < $1.distance }
                .prefix(5) // Only top 5 nearest
                .map { $0 }
            
        case .lastChance:
            return all
                .filter { $0.lastOnes }
                .sorted { ($0.rating ?? 0) > ($1.rating ?? 0) } // Highest rated first
            
        case .new:
            return all
                .filter { $0.isNew }
                .sorted { $0.name < $1.name } // Alphabetical
            
        case .meals:
            return all
                .filter { $0.category == .meals }
                .filter { $0.mealTypes.contains(.lunch) || $0.mealTypes.contains(.dinner) }
            
        case .breakfast:
            return all
                .filter { $0.mealTypes.contains(.breakfast) || $0.mealTypes.contains(.snack) }
                .sorted { $0.distance < $1.distance }
            
        case .localSpecialties:
            let latamCuisines = ["Asado", "Ceviche", "Empanadas", "Pupusas", "Arepas", "Feijoada", "Tacos", "Parrilla"]
            return all
                .filter { latamCuisines.contains($0.cuisine) }
                .sorted { $0.rating ?? 0 > $1.rating ?? 0 }
            
        case .groceries:
            return all
                .filter { $0.category == .groceries }
                .sorted { $0.distance < $1.distance }
            
        case .popularToday:
            return all
                .filter { $0.isPopular || $0.todaysMostCoveted }
                .sorted { $0.rating ?? 0 > $1.rating ?? 0 }
        }
    }
}
