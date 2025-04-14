//
//  FavoriteRow.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 14/04/2025.
//

import SwiftUI

struct FavoriteRow: View {
    
    let manga: MangaModel.Manga
    
    var body: some View {
        GroupBox {
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
                    .imageScale(.large)
                VStack(alignment: .leading) {
                    Text(manga.title).font(.title3)
                    Text(manga.authors.first?.fullName ?? "").font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .backgroundStyle(.thinMaterial)
    }
}

#Preview {
    FavoriteRow(manga: .preview)
}
