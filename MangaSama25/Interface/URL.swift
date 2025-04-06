//
//  URL.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

/// URL base para la API de mangas.
let baseListURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list")!

/// Extensión que proporciona endpoints y constructores de URL para la API de mangas.
extension URL {
    /// URL para listar mangas generales.
    static let mangas = baseListURL.appending(path: "mangas")
    
    /// Construye una URL para obtener la lista de mangas paginada.
    /// - Parameters:
    ///   - page: Número de página
    ///   - per: Elementos por página
    /// - Returns: URL configurada para la petición
    static func getMangas(page: String, per: String) -> URL {
        mangas
            .appending(queryItems: [.pageQuery(page: page),
                                    .perQuery(per: per)])
    }

}


/// Extensión que proporciona constructores para los parámetros de consulta comunes.
extension URLQueryItem {
    /// Crea un parámetro de consulta para la página.
    /// - Parameter page: Número de página
    /// - Returns: URLQueryItem configurado
    static func pageQuery(page: String) -> URLQueryItem {
        URLQueryItem(name: "page", value: page)
    }
    
    /// Crea un parámetro de consulta para número de elementos por página.
    /// - Parameter per: Número de elementos
    /// - Returns: URLQueryItem configurado
    static func perQuery(per: String) -> URLQueryItem {
        URLQueryItem(name: "per", value: per)
    }
}
