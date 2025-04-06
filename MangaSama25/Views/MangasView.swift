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
                Text(manga.title)
                    .font(.headline)
            }
            .task {
                if vm.mangas.isEmpty {
                    await vm.getMangas()
                }
            }
        }
        .navigationTitle("Mangas")
    }
}

#Preview {
    NavigationStack {
        MangasView(vm: .preview)
    }
}
