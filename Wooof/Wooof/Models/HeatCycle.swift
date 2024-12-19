import Foundation
import SwiftData

@Model
class HeatCycle {
    var id: UUID
    var startDate: Date
    var stage: String  // Added stage property
    var endDate: Date?
    var symptoms: [String]
    var notes: String?

    init(id: UUID = UUID(), startDate: Date, stage: String, endDate: Date? = nil, symptoms: [String] = [], notes: String? = nil) {
        self.id = id
        self.startDate = startDate
        self.stage = stage
        self.endDate = endDate
        self.symptoms = symptoms
        self.notes = notes
    }
}


