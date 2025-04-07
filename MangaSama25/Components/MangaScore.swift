//
//  MangaScore.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 07/04/2025.
//

import SwiftUI

enum ScoreSize: Double {
    case small = 0.6
    case medium = 0.8
    case large = 1.0
}

struct MangaScore: View {
    
    let score: Double
    let size: ScoreSize
    
    private let minValue = 0.0
    private let maxValue = 100.0
    private var gaugeColor: Color {
        switch score {
            case 8...10: return .green
            case 6..<8: return .blue
            case 4..<6: return .yellow
            default: return .red
        }
    }
    
    var body: some View {
        ZStack {
            Gauge(value: score*10, in: minValue...maxValue) {
                Text(String(format: "%.1f", score))
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .scaleEffect(size.rawValue)
            .tint(gaugeColor)
        }
    }
}

#Preview {
    HStack(spacing: 20) {
        MangaScore(score: 2.5, size: .large)
        MangaScore(score: 7.5, size: .medium)
        MangaScore(score: 8.5, size: .small)
    }
}
