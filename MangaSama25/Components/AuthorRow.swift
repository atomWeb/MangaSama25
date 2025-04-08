//
//  AuthorRow.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 07/04/2025.
//

import SwiftUI

struct AuthorRow: View {
    let authors: [MangaModel.Author]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(authors) { author in
                HStack(alignment: .top, spacing: 12) {
                    LabeledContent {
                        Text(author.fullName ?? "")
                    } label: {
                        Text(author.role)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
            }
        }
    }
}

#Preview {
    AuthorRow(authors: .preview)
}
