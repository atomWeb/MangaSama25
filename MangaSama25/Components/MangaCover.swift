//
//  MangaCover.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import SwiftUI

struct MangaCover: View {
    /// URL de la imagen de portada a cargar.
    ///
    /// Si es nil o inválida, se mostrará una imagen por defecto del sistema.
    let url: URL?
    /// Altura deseada para la vista de la portada.
    ///
    /// El ancho se ajustará automáticamente manteniendo la proporción de aspecto.
    let height: CGFloat
    
    let radius: CGFloat
    /// ViewModel que maneja la lógica de carga de la imagen.
    @State private var cvm = MangaCoverVM()
    
    /// Crea una nueva vista de portada.
    ///
    /// - Parameters:
    ///   - url: URL opcional que apunta a la imagen de la portada.
    ///   - height: Altura deseada para la vista. Por defecto es 300 puntos.
    init(url: URL?, height: CGFloat = 300, radius: CGFloat = 10) {
        self.url = url
        self.height = height
        self.radius = radius
    }
    
    /// El cuerpo de la vista que representa la portada.
    ///
    /// La vista alterna entre dos estados:
    /// - Si la imagen está cargada, muestra la portada
    /// - Si la imagen no está cargada, muestra un icono de libro por defecto
    var body: some View {
        if let image = cvm.coverImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: height)
                .clipShape(RoundedRectangle(cornerRadius: radius))
        } else {
            Image(systemName: "book.pages.fill")
                .resizable()
                .scaledToFit()
                .frame(height: height)
                .onAppear {
                    cvm.getImage(url: url)
                }
        }
    }
}

#Preview {
    GroupBox {
        MangaCover(url: MangaModel.Manga.preview.mainPicture)
    }
}
