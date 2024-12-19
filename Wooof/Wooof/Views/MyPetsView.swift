import SwiftUI
import SwiftData

struct MyPetsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var dogs: [Dog] // Fetch the list of dogs from SwiftData

    @State private var isFormPresented = false // Control form presentation
    @State private var editingDog: Dog? = nil // Track the dog being edited
    @State private var showDeleteAlert = false // Control delete alert
    @State private var dogToDelete: Dog? = nil // Track the dog to delete

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    // Header Section
                    Text("My Pets")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 10)

                    if dogs.isEmpty {
                        // Empty State
                        VStack(spacing: 15) {
                            Image(systemName: "pawprint.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.pink.opacity(0.7))

                            Text("No Pets Found")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)

                            Text("Tap the '+' button to add your first pet.")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray.opacity(0.7))
                        }
                        .padding()
                    } else {
                        // Grid Layout for Pets
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                ForEach(dogs) { dog in
                                    PetDisplayCard(dog: dog, onDelete: {
                                        dogToDelete = dog
                                        showDeleteAlert = true
                                    })
                                    .onTapGesture {
                                        editingDog = dog
                                        isFormPresented = true
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                        }
                    }
                }

                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            editingDog = nil
                            isFormPresented = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.pink)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isFormPresented) {
                AddEditPetView(dog: editingDog) { newDog in
                    if let editingDog = editingDog {
                        updateDog(editingDog, with: newDog)
                    } else {
                        addDog(newDog)
                    }
                }
            }
            .alert("Are you sure you want to delete this pet?", isPresented: $showDeleteAlert, presenting: dogToDelete) { dog in
                Button("Delete", role: .destructive) {
                    deleteDog(dog)
                }
                Button("Cancel", role: .cancel) {}
            } message: { _ in
                Text("This action cannot be undone.")
            }
        }
    }

    // MARK: - Functions

    private func addDog(_ newDog: Dog) {
        modelContext.insert(newDog)
    }

    private func updateDog(_ dog: Dog, with newDog: Dog) {
        dog.name = newDog.name
        dog.breed = newDog.breed
        dog.age = newDog.age
        dog.lastCycleDate = newDog.lastCycleDate
    }

    private func deleteDog(_ dog: Dog) {
        modelContext.delete(dog)
    }
}

struct PetDisplayCard: View {
    let dog: Dog
    let onDelete: () -> Void // Closure for delete action

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            // Pet Image Placeholder
            Image("dog_profile_picture") // Placeholder image
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.pink, lineWidth: 2))
                .shadow(radius: 4)

            // Pet Details
            VStack(spacing: 4) {
                Text(dog.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text("Breed: \(dog.breed)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Age: \(dog.age) years")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if let cycleDate = dog.lastCycleDate {
                    Text("Last Cycle: \(cycleDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    Text("Last Cycle: N/A")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            // Delete Button
            Button(action: onDelete) {
                HStack {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                    Text("Delete")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 220)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.pink.opacity(0.1)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(15)
    }
}

#Preview {
    MyPetsView()
}
