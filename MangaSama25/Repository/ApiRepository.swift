//
//  ApiRepository.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

/// Protocolo que define las operaciones de red para obtener datos de mangas.
///
/// Este protocolo define una interfaz para realizar peticiones asíncronas
/// a un API de mangas, soportando diferentes tipos de consultas y filtrado.
///
/// Conforme a `Sendable` para garantizar seguridad en concurrencia.
protocol ApiDataRepository: Sendable {
    /// Obtiene una lista paginada de mangas.
    /// - Parameters:
    ///   - page: Número de página solicitada
    ///   - per: Cantidad de elementos por página
    /// - Returns: Modelo con la lista de mangas y metadatos
    /// - Throws: ``NetworkError`` si ocurre un error en la petición
    func getMangas(page: String, per: String) async throws(NetworkError) -> MangaModel
}

/// Implementación concreta del repositorio de datos que utiliza la red.
///
struct ApiRepository: ApiDataRepository, NetworkInteractor {
    func getMangas(page: String, per: String) async throws(NetworkError) -> MangaModel {
        try await getJSON(request: .get(.getMangas(page: page, per: per)), type: MangaDTO.self).mapToModel
    }
}
