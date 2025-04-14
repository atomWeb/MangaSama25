//
//  FavoritesVM.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 14/04/2025.
//

import Foundation

@Observable
final class FavoritesVM {
    
    let repository: FavoritesDataRepository
    
    var favorites: [MangaModel.Manga] = [] {
        didSet {
            try? repository.saveFavorites(mangas: favorites)
        }
    }
    
    init(favoritesDataRepo: FavoritesDataRepository = FavoritesRepository()) {
        self.repository = favoritesDataRepo
        fetchFavorites()
    }
    
    func fetchFavorites() {
        do {
            favorites = try repository.getFavorites()
        } catch {
            print(error) // Pendiente gestionar error
        }
    }
    
    func saveFavorite(manga: MangaModel.Manga) {
        if favorites.contains(where: { $0.id == manga.id }) {
            favorites.removeAll { $0.id == manga.id }
        } else {
            favorites.append(manga)
        }
    }
    
    func isFavorite(manga: MangaModel.Manga) -> Bool {
        favorites.contains { $0.id == manga.id }
    }
    
}
