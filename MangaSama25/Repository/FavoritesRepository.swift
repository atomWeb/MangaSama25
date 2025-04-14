//
//  FavoritesRepository.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 14/04/2025.
//

import Foundation

protocol FavoritesDataRepository {
    func getFavorites() throws -> [MangaModel.Manga]
    func saveFavorites(mangas: [MangaModel.Manga]) throws
}


struct FavoritesRepository: FavoritesDataRepository {
    
    let favoritesURL = URL.documentsDirectory.appending(path: "favorites.json")
    
    func getFavorites() throws -> [MangaModel.Manga] {
        if FileManager.default.fileExists(atPath: favoritesURL.path()) {
            let data = try Data(contentsOf: favoritesURL)
            return try JSONDecoder().decode([MangaModel.Manga].self, from: data)
        } else {
            return []
        }
    }
    
    func saveFavorites(mangas: [MangaModel.Manga]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(mangas)
        try data.write(to: favoritesURL, options: [.atomic, .completeFileProtection])
    }
}

