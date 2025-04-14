//
//  PreviewRepository.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

private func getPreviewJSON<JSON>(url: URL, type: JSON.Type) throws(NetworkError) -> JSON where JSON: Decodable {
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.apiDateFormatter())
        return try decoder.decode(type, from: data)
    } catch {
        throw .general(error)
    }
}

struct PreviewRepository: ApiDataRepository {
    func getMangas(page: String, per: String) async throws(NetworkError) -> MangaModel {
        try getPreviewJSON(url: Bundle.main.url(forResource: "MangasPreview", withExtension: "json")!, type: MangaDTO.self).mapToModel
    }
}

struct PreviewFavoritesRepository: FavoritesDataRepository {
    func getFavorites() throws -> [MangaModel.Manga] {
        let allMangas = try getPreviewJSON(url: Bundle.main.url(forResource: "MangasPreview", withExtension: "json")!, type: MangaDTO.self).mapToModel.items
        return Array(allMangas.suffix(3))
    }
    
    func saveFavorites(mangas: [MangaModel.Manga]) throws {}
}
