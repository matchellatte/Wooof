import Foundation
import SwiftUI
import SwiftData

struct AddEditPetView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var breed: String = ""
    @State private var age: String = ""
    @State private var lastCycleDate: Date = Date()

    var dog: Dog?
    var onSave: (Dog) -> Void
    var onDelete: (() -> Void)? // Optional closure for delete action

    init(dog: Dog?, onSave: @escaping (Dog) -> Void, onDelete: (() -> Void)? = nil) {
        self.dog = dog
        self.onSave = onSave
        self.onDelete = onDelete
        if let dog = dog {
            _name = State(initialValue: dog.name)
            _breed = State(initialValue: dog.breed)
            _age = State(initialValue: "\(dog.age)")
            _lastCycleDate = State(initialValue: dog.lastCycleDate ?? Date())
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title
                Text(dog == nil ? "Add New Pet" : "Edit Pet")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.pink)
                    .padding(.top, 30)

                // Form
                VStack(spacing: 16) {
                    // Pet Name Input
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Pet Name")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextField("Enter pet name", text: $name)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }

                    // Breed Input
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Breed")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextField("Enter breed", text: $breed)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }

                    // Age Input
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Age (Years)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextField("Enter age", text: $age)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }

                    // Last Cycle Date Picker
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Last Cycle Date")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        DatePicker("", selection: $lastCycleDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)

                // Save Button
                Button(action: savePet) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Delete Button (Only for editing)
                if dog != nil {
                    Button(action: deletePet) {
                        Text("Delete")
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }

                // Cancel Button
                Button(action: { dismiss() }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .foregroundColor(.pink)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }

    // MARK: - Save Pet
    private func savePet() {
        guard let ageInt = Int(age), !name.isEmpty, !breed.isEmpty else { return }
        let newDog = Dog(name: name, breed: breed, age: ageInt, lastCycleDate: lastCycleDate)
        onSave(newDog)
        dismiss()
    }

    // MARK: - Delete Pet
    private func deletePet() {
        onDelete?()
        dismiss()
    }
}
