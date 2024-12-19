import Foundation
import SwiftData

@Model
class Dog {
    var id: UUID
    var name: String
    var breed: String
    var age: Int
    var lastCycleDate: Date?
    var heatCycles: [HeatCycle] = []

    init(id: UUID = UUID(), name: String, breed: String, age: Int, lastCycleDate: Date? = nil) {
        self.id = id
        self.name = name
        self.breed = breed
        self.age = age
        self.lastCycleDate = lastCycleDate
    }
}
