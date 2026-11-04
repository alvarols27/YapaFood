//
//  ContentView.swift
//  FoodieApp
//
//  Created by Alvaro Limaymanta Soria on 2026-01-06.
//

import SwiftUI

struct ContentView: View {

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif

    var body: some View {
        HomeView()
        .enableInjection()
    }
}

#Preview {
    ContentView()
}
