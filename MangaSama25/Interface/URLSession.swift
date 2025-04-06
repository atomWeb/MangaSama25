//
//  URLSession.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

/// Extensión que proporciona métodos mejorados para peticiones de red.
///
/// Agrega manejo de errores tipado y validación de respuestas HTTP.
extension URLSession {
    
    /// Realiza una petición HTTP y retorna los datos y la respuesta HTTP validada.
    ///
    /// - Parameter request: La petición URLRequest a realizar
    /// - Returns: Tupla con los datos recibidos y la respuesta HTTP validada
    /// - Throws: ``NetworkError`` si ocurre algún error durante la petición
    func getData(for request: URLRequest) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw .general(error)
        }
    }
}
