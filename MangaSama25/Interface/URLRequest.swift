//
//  URLRequest.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

/// Métodos "verbos" HTTP soportados para las peticiones de red.
///
/// Define los métodos HTTP estándar utilizados en las peticiones API.
enum HTTPMethod: String {
    /// Método POST para crear recursos.
    case post = "POST"
    
    /// Método GET para obtener recursos.
    case get = "GET"
    
    /// Método DELETE para eliminar recursos.
    case delete = "DELETE"
    
    /// Método PUT para actualizar recursos.
    case put = "PUT"
}

/// Extensión que proporciona métodos para crear peticiones HTTP.
extension URLRequest {
    
    /// Crea una petición GET con su configuración.
    ///
    /// - Parameter url: URL del endpoint
    /// - Returns: Petición URLRequest configurada para GET
    static func get(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    /// Método genérico que crea una petición POST (u otro método) con cuerpo JSON.
    ///
    /// - Parameters:
    ///   - url: URL del endpoint
    ///   - body: Objeto codificable como JSON para el cuerpo de la petición
    ///   - apiKey: Clave API para lanzar peticiones tipo post.
    ///   - method: Método HTTP a utilizar (por defecto POST)
    /// - Returns: Petición URLRequest configurada
    static func post<JSON>(url: URL,
                           body: JSON,
                           apiKey: String,
                           method: HTTPMethod = .post) -> URLRequest where JSON: Encodable {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("\(apiKey)", forHTTPHeaderField: "App-Token")
        request.httpBody = try? JSONEncoder().encode(body)
        return request
    }
}
