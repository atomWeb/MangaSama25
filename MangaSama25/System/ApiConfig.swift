//
//  ApiConfig.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

final class ApiConfig {
    @MainActor static let shared = ApiConfig()
    private(set) var apiKey: String?
    private(set) var apiToken: String?
    
    private init() {
        let config = Self.loadConfig()
        self.apiKey = config?["apiKey"]
        self.apiToken = loadSavedToken() ?? config?["apiToken"]
    }
    
    private static func loadConfig() -> [String: String]? {
        guard let url = Bundle.main.url(forResource: "ApiConfig", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListDecoder().decode([String: String].self, from: data) else {
            return nil
        }
        return plist
    }
    
    // Método para guardar el token
    func saveToken(_ token: String) {
        self.apiToken = token
        UserDefaults.standard.set(token, forKey: "apiToken")
    }
    
    // Método privado para cargar el token guardado
    private func loadSavedToken() -> String? {
        return UserDefaults.standard.string(forKey: "apiToken")
    }
    
    // Método para limpiar el token guardado
    func clearSavedToken() {
        self.apiToken = nil
        UserDefaults.standard.removeObject(forKey: "apiToken")
    }
}
