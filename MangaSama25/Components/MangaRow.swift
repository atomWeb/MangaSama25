//
//  MangaRow.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import SwiftUI

struct MangaRow: View {
    
    @Environment(MangasVM.self) var vm
    @Environment(FavoritesVM.self) var fvm
    
    /// Variable para el manga a mostrar
    let manga: MangaModel.Manga
    
    var body: some View {
        HStack {
            MangaCover(url: manga.mainPicture, height: 120)
            Spacer()
            MangaScore(score: manga.score, size: .small)
            VStack(alignment: .leading) {
                Text(manga.title)
                    .font(.title2)
                    .lineLimit(2)
                HStack {
                    Image(systemName: "heart.circle")
                        .foregroundStyle(fvm.isFavorite(manga: manga) ? .red : .gray)
                    Image(systemName: "person.circle")
                        .foregroundStyle(.gray)
                    Text("\(manga.status.description)")
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .backgroundStyle(.thinMaterial)
        .onAppear {
            vm.getNextPage(manga: manga)
        }
    }
    
}

#Preview {
    MangaRow(manga: .preview)
        .environment(MangasVM.preview)
        .environment(FavoritesVM.preview)
}
