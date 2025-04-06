//
//  NetworkInteractor.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

/// Protocolo que define comportamiento base para interacciones de red.
///
/// `NetworkInteractor` proporciona funcionalidad común para realizar
/// peticiones de red y decodificar respuestas tipo JSON.
protocol NetworkInteractor {}

/// Extensión que implementa funcionalidad común de red.
extension NetworkInteractor {
    /// Realiza una petición HTTP y decodifica la respuesta JSON.
    ///
    /// Este método:
    /// - Realiza la petición HTTP
    /// - Valida el código de estado de la petición
    /// - Decodifica la respuesta a un tipo de datos específico (pasado por parámetro)
    /// - Maneja fechas en formato API
    ///
    /// - Parameters:
    ///   - request: La petición URLRequest a realizar
    ///   - type: El tipo al que decodificar la respuesta
    /// - Returns: Instancia decodificada del tipo especificado
    /// - Throws: ``NetworkError`` si ocurre algún error durante la petición o decodificación
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws(NetworkError) -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == 200 {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.apiDateFormatter())
                return try decoder.decode(type, from: data)
            } catch {
                print(error)
                throw .json(error)
            }
        } else {
            throw .status(response.statusCode)
        }
    }
}
