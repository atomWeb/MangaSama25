//
//  ImageCacheHandler.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import SwiftUI

/// Actor que gestiona la descarga y caché de imágenes de forma concurrente.
///
/// `ImageCacheHandler` implementa un sistema de caché en memoria y disco para imágenes,
/// manejando descargas concurrentes y evitando duplicados.
///
/// # Ejemplo de uso:
/// ```swift
/// let image = try await ImageDownloader.shared.getImage(url: imageURL)
/// ```
actor ImageCacheHandler {
    static let shared = ImageCacheHandler()
    
    /// Estado de una imagen en el sistema.
    private enum ImageStatus {
        /// La imagen está en proceso de descarga.
        case downloading(task: Task<UIImage, Error>)
        /// La imagen ya ha sido descargada.
        case downloaded(image: UIImage)
    }
    
    /// Caché en disco de imágenes y sus estados.
    private var cache: [URL: ImageStatus] = [:]
    
    /// Obtiene una imagen de una URL, usando la de caché si está disponible.
    ///
    /// - Parameter url: URL de la imagen a descargar
    /// - Returns: La imagen descargada
    /// - Throws: Error si falla la descarga o el procesamiento
    func getImage(url: URL) async throws -> UIImage {
        if let status = cache[url] {
            switch status {
            case .downloading(let task):
                return try await task.value
            case .downloaded(let image):
                return image
            }
        }

        let task = Task { try await getNetworkImage(url: url) }
        cache[url] = .downloading(task: task)

        do {
            let image = try await task.value
            cache[url] = .downloaded(image: image)
            try await saveImageToCache(url: url)
            return image
        } catch {
            cache.removeValue(forKey: url)
            throw error
        }
    }
    
    /// Descarga una imagen de la red.
    private func getNetworkImage(url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        return image
    }
    
    /// Guarda una imagen en el disco, para utilizar como caché.
    private func saveImageToCache(url: URL) async throws {
        guard let imageCache = cache[url] else { return }
        let imageName = url.lastPathComponent  // ultimo
        let pathCache = URL.cachesDirectory.appending(path: imageName)

        if case .downloaded(let image) = imageCache,
            let uiImage = await image.byPreparingThumbnail(ofSize: image.size),
            let heicData = uiImage.heicData()
        {
            try heicData.write(to: urlDoc(url: pathCache), options: .atomic)
            cache.removeValue(forKey: url)
        }

    }
    
    /// Obtiene la URL del documento en caché para una URL de imagen.
    ///
    /// Esta función es no aislada (Se puede llamar sin usar `await`) y puede llamarse desde cualquier contexto concurrente porque No necesita acceder a ningún estado mutable del actor.
    ///
    /// - Parameter url: URL original de la imagen
    /// - Returns: URL donde se almacenará la imagen en caché
    nonisolated func urlDoc(url: URL) -> URL {
        let path = url.deletingPathExtension().appendingPathExtension("heic").lastPathComponent
        return URL.cachesDirectory.appending(path: path)
    }
}
