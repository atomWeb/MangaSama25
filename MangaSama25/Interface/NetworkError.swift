//
//  NetworkError.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

/// Errores que pueden ocurrir durante operaciones de red.
///
/// `NetworkError` proporciona una enumeración tipada de los diferentes
/// errores que pueden surgir durante peticiones de red y operaciones JSON.
enum NetworkError: LocalizedError {
    /// Error general de red.
    /// - Parameter error: El error original que ocurrió
    case general(Error)
    
    /// Error de código de estado HTTP.
    /// - Parameter int: El código de estado HTTP recibido
    case status(Int)
    
    /// Error en la decodificación JSON.
    /// - Parameter error: El error de decodificación original
    case json(Error)
    
    /// La respuesta no era HTTP.
    case nonHTTP
    
    /// Descripción localizada del error.
    ///
    /// Proporciona mensajes de error amigables para el usuario
    /// basados en el tipo específico de error.
    var errorDescription: String? {
        switch self {
        case .general(let error):
            "General error: \(error.localizedDescription)."
        case .status(let int):
            "Status error: \(int)."
        case .json(let error):
            "JSON Decoding error: \(error)"
        case .nonHTTP:
            "The response was not a HTTP response."
        }
    }
}
