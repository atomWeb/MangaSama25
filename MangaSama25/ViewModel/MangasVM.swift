//
//  MangasVM.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

@Observable
final class MangasVM {
    /// Repositorio para acceder a los datos de la API.
    let apiDataRepository: ApiDataRepository
    
    /// Número de mangas por página.
    let pageSize: Int = 20
    
    /// Inicializador de página actual para el listado.
    private var page: Int = 1
    
    /// Colecciones de mangas según su tipo.
    var mangas: [MangaModel.Manga] = []
    
    /// Estados de error y alerta.
    var showAlert = false
    var errorMsg = ""
    
    /// Metadatos de paginación para cada tipo de lista.
    var mangasMetadata: MangaModel.Metadata = .empty
    
    /// Inicializa el ViewModel con un repositorio opcional.
    /// - Parameter apiDataRepository: Repositorio para acceder a los datos. Por defecto usa NetworkRepository.
    init(apiDataRepository: ApiDataRepository = ApiRepository()) {
        self.apiDataRepository = apiDataRepository
    }
    
    private func handleError(_ error: Error) {
        self.errorMsg = error.localizedDescription
        showAlert.toggle()
    }
}

/// Extensión que contiene los métodos asíncronos de carga de datos.
@MainActor
extension MangasVM {
    /// Obtiene la lista principal de mangas.
    func getMangas() async {
        do {
            let mangaResult = try await apiDataRepository.getMangas(page: String(page), per: String(pageSize))
            self.mangasMetadata = mangaResult.metadata
            self.mangas += mangaResult.items
        } catch {
            handleError(error)
        }
    }
}
