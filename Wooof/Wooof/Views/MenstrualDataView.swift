//
//  MenstrualDataView.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation
import SwiftUI

struct MenstrualDataView: View {
    let dog: Dog

    var body: some View {
        VStack(spacing: 10) {
            MenstrualDataCard(
                icon: "calendar",
                iconHexColor: "E1364A", // Correct icon color
                label: "Last Menstrual Period",
                detail: dog.lastCycleDate?.formatted(date: .abbreviated, time: .omitted) ?? "Unknown"
            )

            MenstrualDataCard(
                icon: "calendar.badge.clock",
                iconHexColor: "E1364A", // Correct icon color
                label: "Next Predicted Heat Cycle",
                detail: calculateNextDate(from: dog.lastCycleDate ?? Date())
            )
        }
    }

    private func calculateNextDate(from date: Date) -> String {
        let nextDate = Calendar.current.date(byAdding: .day, value: 28, to: date)!
        return nextDate.formatted(date: .abbreviated, time: .omitted)
    }
}

