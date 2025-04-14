//
//  MangaSama25App.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import SwiftUI

@main
struct MangaSama25App: App {
    
    @State var vm = MangasVM()
    @State var fvm = FavoritesVM()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(vm)
                .environment(fvm)
        }
    }
}
