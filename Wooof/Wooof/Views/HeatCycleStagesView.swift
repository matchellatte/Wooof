//
//  HeatCycleStagesView.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation
import SwiftUI

struct HeatCycleStagesView: View {
    let dog: Dog
    let calendar: Calendar

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Dog's Heat Cycle Stages").font(.headline)
            ForEach(calculateStages(), id: \.0) { stage, range, color in
                HStack {
                    Circle().fill(color).frame(width: 15)
                    Text("\(stage): \(range)").foregroundColor(.gray)
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }

    private func calculateStages() -> [(String, String, Color)] {
        [("Proestrus", "Jan 1 - Jan 8", .red), ("Estrus", "Jan 9 - Jan 14", .pink)]
    }
}

