//
//  DogDetailView.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation
import SwiftUI

struct DogDetailView: View {
    @Bindable var dog: Dog
    @State private var showAddCycleView = false

    var body: some View {
        VStack {
            Text(dog.name)
                .font(.largeTitle)
            Text("Breed: \(dog.breed)")
            Text("Age: \(dog.age) years")

            List(dog.heatCycles) { cycle in
                VStack(alignment: .leading) {
                    Text("Start: \(cycle.startDate, format: .dateTime.month().day().year())")
                    if let endDate = cycle.endDate {
                        Text("End: \(endDate, format: .dateTime.month().day().year())")
                    }
                    Text("Symptoms: \(cycle.symptoms.joined(separator: ", "))")
                }
            }
        }
        .navigationTitle(dog.name)
        .toolbar {
            Button(action: { showAddCycleView = true }) {
                Label("Add Cycle", systemImage: "plus")
            }
        }
        .sheet(isPresented: $showAddCycleView) {
            AddHeatCycleView(dog: dog)
        }
    }
}
