//
//  ContentView.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import SwiftUI

struct MangasView: View {

    @State var vm = MangasVM()

    var body: some View {
        NavigationStack {
            List(vm.mangas) { manga in
                NavigationLink(value: manga) {
                    MangaRow(manga: manga)
                }
            }
            .task {
                if vm.mangas.isEmpty {
                    await vm.getMangas()
                }
            }
            .navigationTitle("MangaSama")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: MangaModel.Manga.self) { manga in
                MangaDetailView(manga: manga)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MangasView(vm: .preview)
    }
}
