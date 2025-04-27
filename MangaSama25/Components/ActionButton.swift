//
//  ActionButton.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 14/04/2025.
//

import SwiftUI

struct ActionButton: View {
    let action: () -> Void
    let systemImage: String
    let text: String
    var foreColor: Color = .yellow
    var width: CGFloat = 110 // Ancho fijo por defecto
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: systemImage).foregroundStyle(foreColor)
                Text(text)
            }
            .frame(width: width)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.regular)
    }
}

#Preview {
    ActionButton(action: {}, systemImage: "heart.fill", text: "Favorite")
}
