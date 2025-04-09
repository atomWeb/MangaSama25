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
    
    var pageLoading: Bool = false
    
    /// Inicializa el ViewModel con un repositorio opcional.
    /// - Parameter apiDataRepository: Repositorio para acceder a los datos. Por defecto usa NetworkRepository.
    init(apiDataRepository: ApiDataRepository = ApiRepository()) {
        self.apiDataRepository = apiDataRepository
    }
    
    private func handleError(_ error: Error) {
        self.errorMsg = error.localizedDescription
        showAlert.toggle()
        pageLoading = true
    }
    
    private func lastItem(_ manga: MangaModel.Manga, in list: [MangaModel.Manga]) -> Bool {
        list.last?.id == manga.id
    }
    
    private func nextPage(currentMeta: MangaModel.Metadata, currentManga: MangaModel.Manga, in list: [MangaModel.Manga]) -> Bool {
        return lastItem(currentManga, in: list) && (currentMeta.page * currentMeta.per) < currentMeta.total
    }
}

/// Extensión que contiene los métodos asíncronos de carga de datos.
@MainActor
extension MangasVM {
    /// Obtiene la lista principal de mangas.
    func getMangas() async {
        pageLoading = false
        do {
            let mangaResult = try await apiDataRepository.getMangas(page: String(page), per: String(pageSize))
            self.mangasMetadata = mangaResult.metadata
            self.mangas += mangaResult.items
            pageLoading = true
        } catch {
            handleError(error)
        }
    }
    
    func getNextPage(manga: MangaModel.Manga) {
        let currentMeta: MangaModel.Metadata
        let currentList: [MangaModel.Manga]
        let nextPageAction: () async -> Void
        
        currentMeta = mangasMetadata
        currentList = mangas
        nextPageAction = getMangas
        
        guard nextPage(currentMeta: currentMeta, currentManga: manga, in: currentList) else { return }
        
        page += 1
        
        Task {
            print("Page: \(page)")
            await nextPageAction()
        }
    }
}
