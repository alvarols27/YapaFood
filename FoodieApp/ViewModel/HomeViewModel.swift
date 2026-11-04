//
//  HomeViewModel.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-09.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    private var locationManager: LocationManager?
    
    init() {
        loadSampleData()
    }
    
    func loadSampleData() {
        // Sample restaurants for Peru (using PEN currency)
        self.restaurants = [
            Restaurant(
                id: "1",
                name: "Panadería San Antonio",
                cuisine: "Panadería Peruana",
                distance: 0.8,
                address: "Av. Arequipa 123, Miraflores",
                image: "https://impulsapopular.com/wp-content/uploads/2019/05/4400-Pasos-para-abrir-una-panader%C3%ADa-de-%C3%A9xito.jpg",
                logo: "https://img.freepik.com/premium-vector/bakery-logo-design-template_441059-236.jpg",
                pickupStart: "18:00",
                pickupEnd: "19:30",
                price: 8.50,
                rating: 4.7,
                latitude: -12.122,
                longitude: -77.028,
                isActive: true,
                description: "Pan francés, empanadas y tortas del día",
                category: .bakery,
                mealTypes: [.breakfast, .snack],
                isNew: false,
                isPopular: true,
                lastOnes: true,
                todaysMostCoveted: false,
                isFavourite: true
            ),
            Restaurant(
                id: "2",
                name: "La Picantería",
                cuisine: "Ceviche",
                distance: 1.5,
                address: "Calle Bolívar 456, Lima",
                image: "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
                logo: "https://img.freepik.com/vector-premium/logotipo-restaurante-mariscos_25327-110.jpg",
                pickupStart: "20:00",
                pickupEnd: "21:30",
                price: 15.90,
                rating: 4.9,
                latitude: -12.046,
                longitude: -77.043,
                isActive: true,
                description: "Ceviche mixto con cancha y chicha",
                category: .meals,
                mealTypes: [.lunch, .dinner],
                isNew: true,
                isPopular: true,
                lastOnes: false,
                todaysMostCoveted: true,
                isFavourite: false
            ),
            Restaurant(
                id: "3",
                name: "Mercado de Surquillo",
                cuisine: "Abarrotes",
                distance: 2.1,
                address: "Mercado 1, Surquillo",
                image: "https://images.pexels.com/photos/2255935/pexels-photo-2255935.jpeg",
                logo: "https://static.vecteezy.com/system/resources/previews/023/773/631/non_2x/grocery-store-logo-design-template-vector.jpg",
                pickupStart: "17:00",
                pickupEnd: "18:00",
                price: 12.00,
                rating: 4.5,
                latitude: -12.099,
                longitude: -77.007,
                isActive: true,
                description: "Frutas y verduras frescas del día",
                category: .groceries,
                mealTypes: [.lunch, .dinner],
                isNew: false,
                isPopular: false,
                lastOnes: true,
                todaysMostCoveted: false,
                isFavourite: false
            ),
            Restaurant(
                id: "4",
                name: "Burgers & Beer",
                cuisine: "Americano",
                distance: 0.5,
                address: "Av. Larco 789, Miraflores",
                image: "https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg",
                logo: "https://img.freepik.com/vector-premium/diseno-logotipo-hamburguesa_441059-241.jpg",
                pickupStart: "19:30",
                pickupEnd: "21:00",
                price: 10.50,
                rating: 4.3,
                latitude: -12.126,
                longitude: -77.030,
                isActive: true,
                description: "Hamburguesas artesanales con papas",
                category: .international,
                mealTypes: [.dinner],
                isNew: true,
                isPopular: false,
                lastOnes: false,
                todaysMostCoveted: false,
                isFavourite: true
            ),
            Restaurant(
                id: "5",
                name: "Anticuchos Doña Mary",
                cuisine: "Parrilla",
                distance: 3.2,
                address: "Av. Brasil 2345, Breña",
                image: "https://images.pexels.com/photos/65175/pexels-photo-65175.jpeg",
                logo: "https://static.vecteezy.com/system/resources/previews/024/000/741/non_2x/grill-bbq-logo-free-vector.jpg",
                pickupStart: "21:00",
                pickupEnd: "22:00",
                price: 9.80,
                rating: 4.8,
                latitude: -12.056,
                longitude: -77.050,
                isActive: true,
                description: "Anticuchos, chorizos y choclo",
                category: .meals,
                mealTypes: [.dinner],
                isNew: false,
                isPopular: true,
                lastOnes: true,
                todaysMostCoveted: true,
                isFavourite: false
            )
        ]
    }
    
    func updateLocationManager(_ manager: LocationManager) {
        self.locationManager = manager
        sortRestaurantsByDistance()
    }
    
    private func sortRestaurantsByDistance() {
        guard let location = locationManager?.currentLocation else { return }
        
        restaurants.sort { r1, r2 in
            r1.distanceFrom(location) < r2.distanceFrom(location)
        }
    }
}
