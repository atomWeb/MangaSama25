//
//  PreviewData.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 06/04/2025.
//

import Foundation

extension MangasVM {
    static let preview = MangasVM(apiDataRepository: PreviewRepository())
}

/// Manga de ejemplo para previsualización.
extension MangaModel.Manga {
    static let preview = MangaModel.Manga(
        background: "In 2015, Houseki no Kuni ranked at tenth on the Kono Manga ga Sugoi! rankings in the male readers category. The series has been published in English as Land of the Lustrous by Kodansha Comics USA since June 27, 2017.",
        url: URL(string: "https://myanimelist.net/manga/44489/Houseki_no_Kuni")!,
        titleEnglish: "Land of the Lustrous",
        startDate: Date(timeIntervalSince1970: 968438400),
        authors: [
            MangaModel.Author(
                firstName: "Haruko",
                lastName: "Ichikawa",
                role: "Story & Art",
                id: UUID()
            )
        ],
        genres: [
            MangaModel.Genre(genre: .drama, id: UUID()),
            MangaModel.Genre(genre: .adventure, id: UUID())
        ],
        chapters: nil,
        score: 8.96,
        status: .currentlyPublishing,
        mainPicture: URL(string: "https://cdn.myanimelist.net/images/manga/1/115443l.jpg")!,
        synopsis: "Long ago, Earth was struck by six meteorites, creating six moons and leaving a lone island in their wake. Those who could not make it to the island sank to the bottom of the ocean, where over time they slowly turned to crystal.",
        themes: [
            MangaModel.Theme(theme: .isekai, id: UUID()),
            MangaModel.Theme(theme: .anthropomorphic, id: UUID())
        ],
        titleJapanese: "宝石の国",
        id: 11,
        volumes: 25,
        endDate: nil,
        demographics: [
            MangaModel.Demographic(demographic: .seinen, id: UUID())
        ],
        title: "Houseki no Kuni"
    )
}
