//
//  MangaDTO.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

/// Protocolo que define los requisitos para opciones de filtrado.
///
/// Combina varios protocolos para proporcionar funcionalidad completa
/// de filtrado, identificación y codificación.
protocol FilterOption: Identifiable, CaseIterable, Codable, Hashable, RawRepresentable where RawValue == String  {}

/// Extension para hacer que los enums que cumplan con FilterOption se puedan conformar a Identifiable
extension FilterOption {
    var id: Self { self }
}

/// Estado de publicación de un manga.
///
/// Define los posibles estados de publicación con un manejo especial
/// para valores desconocidos.
enum Status: String, Codable {
    /// En publicación actualmente
    case currentlyPublishing = "currently_publishing"
    /// En pausa temporal
    case onHiatus = "on_hiatus"
    /// Publicación terminada
    case finished
    /// Publicación cancelada
    case discontinued
    /// Estado desconocido (valor por defecto para estados no reconocidos)
    case unknown
    
    /// Descripción para el usurio del estado
    var description: String {
        switch self {
        case .currentlyPublishing:
            return "On Going"
        case .onHiatus:
            return "On Pause"
        case .finished:
            return "Finished"
        case .discontinued:
            return "Discontinued"
        case .unknown:
            return "Unknown Status"
        }
    }
    
    /// Se Implementa el inicializador de Codable manualmente, de modo que **Si se recibe un valor que no coincide con ningún caso**, se usa `unknown`.
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try container.decode(String.self)
        self = Status(rawValue: status) ?? .unknown
    }
}

/// Géneros de un manga.
///
/// Define los posibles géneros de un manga
enum GenreEnum: String, FilterOption {
    case action = "Action"
    case adventure = "Adventure"
    case awardWinning = "Award Winning"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case supernatural = "Supernatural"
    case mystery = "Mystery"
    case sliceOfLife = "Slice of Life"
    case comedy = "Comedy"
    case sciFi = "Sci-Fi"
    case suspense = "Suspense"
    case sports = "Sports"
    case ecchi = "Ecchi"
    case romance = "Romance"
    case girlsLove = "Girls Love"
    case boysLove = "Boys Love"
    case gourmet = "Gourmet"
    case erotica = "Erotica"
    case hentai = "Hentai"
    case avantGarde = "Avant Garde"
}

/// Demografía de un manga.
///
/// Define las posibles demografías a las que va dirigida un manga
enum DemographicEnum: String, FilterOption {
    case seinen = "Seinen"
    case shounen = "Shounen"
    case shoujo = "Shoujo"
    case josei = "Josei"
    case kids = "Kids"
}

/// Temáticas de un manga.
///
/// Define las divisiones por tema de un manga
enum ThemeEnum: String, FilterOption {
    case gore = "Gore"
    case military = "Military"
    case mythology = "Mythology"
    case psychological = "Psychological"
    case historical = "Historical"
    case samurai = "Samurai"
    case romanticSubtext = "Romantic Subtext"
    case school = "School"
    case adultCast = "Adult Cast"
    case parody = "Parody"
    case superPower = "Super Power"
    case teamSports = "Team Sports"
    case delinquents = "Delinquents"
    case workplace = "Workplace"
    case survival = "Survival"
    case childcare = "Childcare"
    case iyashikei = "Iyashikei"
    case reincarnation = "Reincarnation"
    case showbiz = "Showbiz"
    case anthropomorphic = "Anthropomorphic"
    case lovePolygon = "Love Polygon"
    case music = "Music"
    case mecha = "Mecha"
    case combatSports = "Combat Sports"
    case isekai = "Isekai"
    case gagHumor = "Gag Humor"
    case crossdressing = "Crossdressing"
    case reverseHarem = "Reverse Harem"
    case martialArts = "Martial Arts"
    case visualArts = "Visual Arts"
    case harem = "Harem"
    case otakuCulture = "Otaku Culture"
    case timeTravel = "Time Travel"
    case videoGame = "Video Game"
    case strategyGame = "Strategy Game"
    case vampire = "Vampire"
    case mahouShoujo = "Mahou Shoujo"
    case highStakesGame = "High Stakes Game"
    case cgdct = "CGDCT"
    case organizedCrime = "Organized Crime"
    case detective = "Detective"
    case performingArts = "Performing Arts"
    case medical = "Medical"
    case space = "Space"
    case memoir = "Memoir"
    case villainess = "Villainess"
    case racing = "Racing"
    case pets = "Pets"
    case magicalSexShift = "Magical Sex Shift"
    case educational = "Educational"
    case idolsFemale = "Idols (Female)"
    case idolsMale = "Idols (Male)"
}

/// Objeto de Transferencia de Datos (DTO) para la respuesta de manga.
///
/// Proporciona una estructura intermedia para decodificar la respuesta JSON
/// y mapearla al modelo de dominio.
struct MangaDTO: Codable {
    
    /// Estructura para mapear datos de género.
    struct Genre: Codable {
        let genre: GenreEnum
        let id: UUID
        
        /// Convierte el DTO a modelo de dominio.
        var mapToModel: MangaModel.Genre {
            MangaModel.Genre (
                genre: genre,
                id: id
            )
        }
    }
    
    /// Estructura para mapear datos de demograía.
    struct Demographic: Codable {
        let demographic: DemographicEnum
        let id: UUID
        
        /// Convierte el DTO a modelo de dominio.
        var mapToModel: MangaModel.Demographic {
            MangaModel.Demographic (
                demographic: demographic,
                id: id
            )
        }
    }
    
    /// Estructura para mapear datos del autor.
    struct Author: Codable {
        let firstName: String?
        let lastName: String
        let role: String
        let id: UUID
        
        /// Nombre completo del autor, combinando nombre y apellido si está disponible.
        var fullName: String? {
            guard let firstName = self.firstName else { return nil }
            return "\(firstName) \(lastName)"
        }
        
        /// Convierte el DTO a modelo de dominio.
        var mapToModel: MangaModel.Author {
            MangaModel.Author (
                firstName: firstName,
                lastName: lastName,
                role: role,
                id: id
            )
        }
    }
    
    /// Estructura para mapear datos de temática.
    struct Theme: Codable {
        let theme: ThemeEnum
        let id: UUID
        
        /// Convierte el DTO a modelo de dominio.
        var mapToModel: MangaModel.Theme {
            MangaModel.Theme (
                theme: theme,
                id: id
            )
        }
    }
    
    /// Estructura principal de manga con manejo especial de URLs.
    struct Manga: Codable {
        let background: String?
        let titleEnglish: String?
        let startDate: Date?
        let authors: [Author]
        let genres: [Genre]
        let chapters: Int?
        let score: Double
        let status: Status
        let synopsis: String?
        let themes: [Theme]
        let titleJapanese: String?
        let id: Int
        let volumes: Int?
        let endDate: Date?
        let demographics: [Demographic]
        let title: String
        
        /// URL raw de la imagen principal
        private let mainPictureRaw: String
        /// URL raw del manga
        private let urlRaw: String
        /// URL procesada de la imagen principal
        var mainPicture: URL? {
            URL(string: mainPictureRaw.trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
        }
        /// URL procesada del manga
        var url: URL? {
            URL(string: urlRaw.trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
        }
        /// Claves de codificación personalizadas
        enum CodingKeys: String, CodingKey {
            case background
            case urlRaw = "url"
            case titleEnglish
            case startDate
            case authors
            case genres
            case chapters
            case score
            case status
            case mainPictureRaw = "mainPicture"
            case synopsis = "sypnosis"
            case themes
            case titleJapanese
            case id
            case volumes
            case endDate
            case demographics
            case title
        }
        
        /// Convierte el DTO a modelo de dominio
        var mapToModel: MangaModel.Manga {
            MangaModel.Manga (
                background: background,
                url: url,
                titleEnglish: titleEnglish,
                startDate: startDate,
                authors: authors.map(\.mapToModel),
                genres: genres.map(\.mapToModel),
                chapters: chapters,
                score: score,
                status: status,
                mainPicture: mainPicture,
                synopsis: synopsis,
                themes: themes.map(\.mapToModel),
                titleJapanese: titleJapanese,
                id: id,
                volumes: volumes,
                endDate: endDate,
                demographics: demographics.map(\.mapToModel),
                title: title
            )
        }
            
    }
    
    /// Estructura para mapear los metadatos
    struct Metadata: Codable {
        var total: Int
        var page: Int
        var per: Int
        
        /// Convierte el DTO a modelo de dominio.
        var mapToModel: MangaModel.Metadata {
            MangaModel.Metadata (
                total: total,
                page: page,
                per: per
            )
        }
    }
    
    let metadata: Metadata
    let items: [Manga]
    
    /// Convierte el DTO a modelo de dominio.
    var mapToModel: MangaModel {
        MangaModel (
            metadata: metadata.mapToModel,
            items: items.map(\.mapToModel)
        )
    }
}
