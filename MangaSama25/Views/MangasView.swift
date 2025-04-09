//
//  ContentView.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import SwiftUI

struct MangasView: View {

    @Environment(MangasVM.self) var vm

    var body: some View {
        
        @Bindable var bvm = vm
        
        ZStack {
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
                .alert("Error!", isPresented: $bvm.showAlert) {} message: {
                    Text(vm.errorMsg)
                }
                .navigationTitle("MangaSama")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: MangaModel.Manga.self) { manga in
                    MangaDetailView(manga: manga)
                }
                .animation(.easeInOut, value: vm.mangas)
            }
            if (!vm.pageLoading) {
                LoadingView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MangasView()
            .environment(MangasVM.preview)
    }
}
