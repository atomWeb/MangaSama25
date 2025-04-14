//
//  FavoritesView.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 14/04/2025.
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(FavoritesVM.self) var fvm
    
    var body: some View {
        NavigationStack {
            
            List(fvm.favorites) { manga in
                NavigationLink(value: manga) {
                    FavoriteRow(manga: manga)
                }
            }
            .navigationTitle("My Favorites Mangas")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: MangaModel.Manga.self) { manga in
                MangaDetailView(manga: manga)
            }
        }
    }
}

#Preview {
    FavoritesView()
        .environment(FavoritesVM.preview)
}
