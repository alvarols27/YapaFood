//
//  HomeView.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-09.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 24) {
                    LocationHeaderView(locationManager: locationManager)
                    
                    SearchBarPlaceholderView()
                        .padding(.horizontal)
                    
                    //All Sections
                    ForEach(HomeSection.allCases) { section in
                        let items = section.restaurants(from: viewModel.restaurants)
                        
                        // Show section if it has items OR if it's a key section
                        if !items.isEmpty || shouldAlwaysShow(section) {
                            RestaurantSectionView(
                                section: section,
                                restaurants: items
                            )
                        }
                    }
                }
                .padding(.bottom, 30)
            }
            .navigationBarHidden(true)
            .refreshable {
                // Refresh by reloading sample data (will be Firebase later)
                viewModel.loadSampleData()
            }
        }
        .enableInjection()
    }
    
    private func shouldAlwaysShow(_ section: HomeSection) -> Bool {
        // Always show these sections even if empty (for better UX)
        return section == .nearest || section == .lastChance || section == .popularToday
    }
}

struct SearchBarPlaceholderView: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            Text("Buscar restaurantes o comidas...")
                .foregroundColor(.gray)
            Spacer()
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.gray)
        }
        .padding(14)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal, 4)
        .enableInjection()
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 80))
                .foregroundColor(.gray)
            Text("No hay restaurantes disponibles")
                .font(.title3)
                .fontWeight(.semibold)
            Text("Pronto aparecerán nuevas oportunidades\nde reducir desperdicio de comida")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
        .enableInjection()
    }
}

#Preview {
    HomeView()
}
