//
//  MangaModel.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

/// Modelo que representa la respuesta de la API de mangas con metadata y colección de items.
struct MangaModel: Codable {
    
    /// Representa un género de manga.
    struct Genre: Codable, Hashable, Identifiable {
        /// El tipo de género.
        let genre: GenreEnum
        /// Identificador único del género.
        let id: UUID
    }
    
    /// Representa la demografía objetivo del manga.
    struct Demographic: Codable, Hashable, Identifiable {
        /// El tipo de demografía.
        let demographic: DemographicEnum
        /// Identificador único de la demografía.
        let id: UUID
    }
    
    /// Representa un autor de manga.
    struct Author: Codable, Identifiable, Hashable {
        /// Nombre del autor, opcional.
        let firstName: String?
        /// Apellido del autor.
        let lastName: String
        /// Rol del autor en la obra.
        let role: String
        /// Identificador único del autor.
        let id: UUID
        
        /// Nombre completo del autor, combinando nombre y apellido si está disponible.
        var fullName: String? {
            guard let firstName = self.firstName else { return nil }
            return "\(firstName) \(lastName)"
        }
    }
    
    /// Representa un tema del manga.
    struct Theme: Codable, Hashable, Identifiable {
        /// El tipo de tema.
        let theme: ThemeEnum
        /// Identificador único del tema.
        let id: UUID
    }
    
    /// Representa un manga con todos sus atributos.
    struct Manga: Codable, Identifiable, Hashable {
        let background: String? // posible uso?
        let url: URL?
        let titleEnglish: String?
        let startDate: Date?
        let authors: [Author]
        let genres: [Genre]
        let chapters: Int? // posible uso?
        let score: Double
        let status: Status
        let mainPicture: URL?
        let synopsis: String?
        let themes: [Theme]
        let titleJapanese: String?
        let id: Int
        let volumes: Int?
        let endDate: Date? // posible uso?
        let demographics: [Demographic]
        let title: String
        
        /// Fecha de inicio formateada como string.
        ///
        /// Si la fecha no está disponible, retorna "No Date available".
        var startDateStr: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return startDate?.formatted(date: .abbreviated, time: .omitted)
                ?? "No Date available"
        }
        
        /// Número de volúmenes como texto.
        ///
        /// Si no hay volúmenes disponibles, retorna "⁉️".
        var volumesText: String {
            if let volumes = volumes {
                return String(volumes)
            }
            return "⁉️"
        }
    }
    
    /// Metadata de la respuesta del API Rest.
    struct Metadata: Codable {
        /// Número total de items disponibles.
        var total: Int
        /// Página actual.
        var page: Int
        /// Items por página.
        var per: Int
    }

    /// Metadata de la respuesta.
    let metadata: Metadata
    /// Colección de mangas en la respuesta.
    let items: [Manga]
}

extension MangaModel.Metadata {
    static var empty: MangaModel.Metadata {
        .init(total: 0, page: 1, per: 20)
    }
}
