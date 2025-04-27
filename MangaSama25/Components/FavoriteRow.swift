//
//  FavoriteRow.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 14/04/2025.
//

import SwiftUI

struct FavoriteRow: View {
    
    @Environment(FavoritesVM.self) var vmFav
    
    let manga: MangaModel.Manga
    
    var body: some View {
        GroupBox {
            HStack {
                Image(systemName: "heart.circle.fill")
                      .foregroundStyle(.red)
                      .imageScale(.large)
                VStack(alignment: .leading) {
                    Text(manga.title).font(.title3)
                    Text(manga.authors.first?.fullName ?? "").font(.subheadline)
                }
                Spacer()
                MangaCover(url: manga.mainPicture, height: 80, radius: 100)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .backgroundStyle(.thinMaterial)
        .swipeActions {
            Button {
                vmFav.saveFavorite(manga: manga)
            } label: {
                Image(systemName:  "minus.circle.fill")
                    .tint(.yellow).opacity(0.7)
                
            }
                
        }
    }
}

#Preview {
    FavoriteRow(manga: .preview)
        .environment(FavoritesVM.preview)
}
