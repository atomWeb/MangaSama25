//
//  MangaCoverVM.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import SwiftUI

@Observable
final class MangaCoverVM {
    /// Instancia "compartida" o `Singleton` del manejador de imágenes.
    let imageCacheHandler = ImageCacheHandler.shared
    
    /// Imagen de portada actual.
    ///
    /// Se actualiza automáticamente cuando una nueva imagen es cargada.
    var coverImage: UIImage?
    
    /// Obtiene una imagen de forma asíncrona desde una URL.
    /// - Parameter url: URL de la imagen a descargar
    func getImageAsync(url: URL) async {
        do {
            let image = try await ImageCacheHandler.shared.getImage(url: url)
            self.coverImage = image
        } catch {
            print("Error recuperando imagen \(url.absoluteString) : \(error)")
        }
    }
}

/// Extensión que proporciona métodos de acceso a imágenes desde el actor principal.
@MainActor
extension MangaCoverVM {
    
    /// Obtiene una imagen, primero intentando desde el sistema de archivos `caché` y si no existe, la descarga.
    /// - Parameter url: URL opcional de la imagen a obtener
    func getImage(url: URL?) {
        guard let url else { return }
        let docURL = imageCacheHandler.urlDoc(url: url)
        if FileManager.default.fileExists(atPath: docURL.path()),
           let data = try? Data(contentsOf: docURL) {
            coverImage = UIImage(data: data)
        } else {
            Task {
                await getImageAsync(url: url)
            }
        }
    }
}
