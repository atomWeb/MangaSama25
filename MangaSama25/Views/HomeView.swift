//
//  HomeView.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 14/04/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            Tab(value: 0) {
                MangasView()
            } label: {
                Label("Mangas", systemImage: "book")
            }
            Tab(value: 1) {
                FavoritesView()
            } label: {
                Label("Favorites", systemImage: "heart")
            }
        }
        
    }
}

#Preview {
    HomeView()
        .environment(MangasVM.preview)
        .environment(FavoritesVM.preview)
}
