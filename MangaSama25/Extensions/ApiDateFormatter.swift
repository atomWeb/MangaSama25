//
//  ApiDateFormatter.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

/// Extensión que proporciona un formateador de fechas específico para la API.
extension DateFormatter {
    
    /// Crea un formateador de fechas configurado para el formato de la API.
    ///
    /// El formato utilizado es "yyyy-MM-dd'T'HH:mm:ssZ", que corresponde a
    /// fechas ISO 8601 como "2024-01-26T15:30:00+0000".
    ///
    /// # Ejemplo de uso:
    /// ```swift
    /// let formatter = DateFormatter.apiDateFormatter()
    /// let dateStr = "2024-01-26T15:30:00+0000"
    /// let date = formatter.date(from: dateStr)
    /// ```
    ///
    /// - Returns: Un DateFormatter configurado para el formato de la API
    static func apiDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
}

