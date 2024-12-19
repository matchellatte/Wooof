import SwiftUI
import SwiftData

struct AddHeatCycleView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var dog: Dog

    @State private var startDate = Date()
    @State private var endDate: Date?
    @State private var selectedStage = "Proestrus"
    @State private var symptoms: String = ""
    @State private var notes: String = ""

    private let stages = ["Proestrus", "Estrus", "Diestrus", "Anestrus"]

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Heat Cycle Details Section
                Section(header: Text("Heat Cycle Details").font(.headline)) {
                    // Start Date
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)

                    // End Date
                    DatePicker("End Date (Optional)", selection: Binding(
                        get: { endDate ?? startDate },
                        set: { newValue in endDate = newValue }
                    ), in: startDate..., displayedComponents: .date)
                    .foregroundColor(.gray)

                    // Cycle Stage Picker
                    Picker("Stage", selection: $selectedStage) {
                        ForEach(stages, id: \.self) { stage in
                            Text(stage).tag(stage)
                        }
                    }
                    .pickerStyle(.menu)
                }

                // MARK: - Symptoms Section
                Section(header: Text("Symptoms").font(.headline)) {
                    TextField("Enter symptoms (comma separated)", text: $symptoms)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.vertical, 5)
                }

                // MARK: - Notes Section
                Section(header: Text("Notes").font(.headline)) {
                    TextField("Additional notes (optional)", text: $notes)
                        .autocapitalization(.sentences)
                        .lineLimit(3)
                }
            }
            .navigationTitle("Add Heat Cycle")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveHeatCycle()
                    }
                    .fontWeight(.bold)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                initializeEndDate()
            }
        }
    }

    // MARK: - Initialize End Date to Start Date
    private func initializeEndDate() {
        endDate = startDate
    }

    // MARK: - Save Heat Cycle
    private func saveHeatCycle() {
        // Create new HeatCycle instance
        let newHeatCycle = HeatCycle(
            startDate: startDate,
            stage: selectedStage,
            endDate: endDate,
            symptoms: symptoms.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
            notes: notes.isEmpty ? nil : notes
        )

        // Append to the dog's heat cycles
        dog.heatCycles.append(newHeatCycle)

        // Dismiss the view
        dismiss()
    }
}
