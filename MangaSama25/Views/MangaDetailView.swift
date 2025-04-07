//
//  MangaDetailView.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 07/04/2025.
//

import SwiftUI

struct MangaDetailView: View {
    
    /// Variable para el manga a mostrar
    let manga: MangaModel.Manga
    
    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    MangaScore(score: manga.score, size: .medium)
                        .padding(.trailing)
                    VStack(alignment: .leading) {
                        Text(manga.title)
                            .font(.title3)
                            .bold()
                        Text(manga.titleJapanese ?? "No Japanese Title available")
                    }
                }
                
                Divider()
                
                MangaCover(url: manga.mainPicture, height: 280)
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 3)
                    .padding(.top, 4) // Espacio sobre la imagen
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    MangaDetailView(manga: .preview)
}
