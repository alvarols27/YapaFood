//
//  RestaurantDetailView.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-05-02.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                        // Hero image
                        if let url = URL(string: restaurant.image), !restaurant.image.isEmpty {
                            WebImage(url: url)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 230)
                                .frame(maxWidth: .infinity)
                                .clipped()
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 240)
                                .frame(maxWidth: .infinity)
                                .overlay {
                                    Image(systemName: "photo.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.gray)
                                }
                        }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(restaurant.name)
                            .font(.largeTitle)
                            .bold()
                        
                        Text(restaurant.cuisine)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Precio")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("S/ \(restaurant.price, specifier: "%.2f")")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.green)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Recogida")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(restaurant.pickupStart)-\(restaurant.pickupEnd)")
                                    .font(.body)
                            }
                        }
                        
                        Divider()
                        
                        Text("Descripción")
                            .font(.headline)
                        Text(restaurant.description)
                            .font(.body)
                        
                        Divider()
                        
                        Text("Dirección")
                            .font(.headline)
                        Text(restaurant.address)
                            .font(.body)
                        
                        Spacer(minLength: 30)
                        
                        Button(action: {
                            //MARK: HACER BOLSA
                            dismiss()
                        }) {
                            Text("Reservar Bolsa")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.headline)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .padding(.top, -130)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("←") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
