//
//  LoadingView.swift
//  MangaSama25
//
//  Created by Cristian Jose Perez Guerra on 09/04/2025.
//

import SwiftUI

struct LoadingView: View {

    @State private var isSpinning = false
    
    var body: some View {
        ZStack {

            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            

            VStack(spacing: 20) {

                Image("spinner")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(isSpinning ? 360 : 0))
                    .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: isSpinning)
                
                Text("Loading...")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
        }
        .onAppear {
            isSpinning = true
        }
    }
}

#Preview {
    LoadingView()
}
