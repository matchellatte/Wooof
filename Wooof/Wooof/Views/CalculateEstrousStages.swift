import Foundation
import SwiftUI

private let calendar = Calendar.current

func calculateEstrousStages(from startDate: Date) -> [HeatCycle] {
    let proestrusDuration = 7   // Proestrus: 7 days
    let estrusDuration = 5      // Estrus: 5 days
    let diestrusDuration = 60   // Diestrus: 60 days
    let anestrusDuration = 60   // Anestrus: 60 days

    // Calculate each stage's start and end dates
    let proestrusStart = startDate
    let proestrusEnd = calendar.date(byAdding: .day, value: proestrusDuration, to: proestrusStart)!

    let estrusStart = proestrusEnd
    let estrusEnd = calendar.date(byAdding: .day, value: estrusDuration, to: estrusStart)!

    let diestrusStart = estrusEnd
    let diestrusEnd = calendar.date(byAdding: .day, value: diestrusDuration, to: diestrusStart)!

    let anestrusStart = diestrusEnd
    let anestrusEnd = calendar.date(byAdding: .day, value: anestrusDuration, to: anestrusStart)!

    // Create and return HeatCycle objects for each stage
    return [
        HeatCycle(startDate: proestrusStart, stage: "Proestrus", endDate: proestrusEnd),
        HeatCycle(startDate: estrusStart, stage: "Estrus", endDate: estrusEnd),
        HeatCycle(startDate: diestrusStart, stage: "Diestrus", endDate: diestrusEnd),
        HeatCycle(startDate: anestrusStart, stage: "Anestrus", endDate: anestrusEnd)
    ]
}
