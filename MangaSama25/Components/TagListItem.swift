//
//  TagListItem.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 07/04/2025.
//

import SwiftUI

struct TagListItem<T: Identifiable>: View {
    /// La colección de elementos a mostrar como etiquetas.
    ///
    /// Cada elemento debe conformar al protocolo `Identifiable`.
    let items: [T]
    /// Una `closure` que convierte cada elemento en el texto a mostrar.
    ///
    /// - Parameter item: El elemento a convertir en texto
    /// - Returns: El texto que se mostrará en la etiqueta
    let getText: (T) -> String
    /// El cuerpo de la vista que compone la lista horizontal de etiquetas.
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { item in
                    Text(getText(item))
                        .font(.footnote)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }
}
