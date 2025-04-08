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
                
                MangaCover(url: manga.mainPicture, height: 250)
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 3)
                
                if let url = manga.url {
                    Link(destination: url) {
                        HStack {
                            
                            Text("Bibliography")
                            
                            Image(systemName: "network")
                                .foregroundStyle(.blue)
                        }
                        .foregroundStyle(.blue)
                        
                    }
                }
                
                Form {
                    Section(header: Text("Manga Details")) {
                        AuthorRow(authors: manga.authors)
                        LabeledContent("Status", value: manga.status.description)
                        LabeledContent("Start Date", value: manga.startDateStr)
                        DisclosureGroup("Synopsis") {
                            Text(manga.synopsis ?? "No data found")
                                .font(
                                    .system(
                                        .headline, design: .rounded, weight: .light)
                                )
                        }
                        DisclosureGroup("Generes") {
                            TagListItem(items: manga.genres) { genre in
                                genre.genre.rawValue
                            }
                        }
                        DisclosureGroup("Themes") {
                            TagListItem(items: manga.themes) { theme in
                                theme.theme.rawValue
                            }
                        }
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    MangaDetailView(manga: .preview)
}
