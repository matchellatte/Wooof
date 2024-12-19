import SwiftUI
import SwiftData

struct DogListView: View {
    @Query var dogs: [Dog]  // Fetch dogs from SwiftData

    @State private var showAddDogView = false

    var body: some View {
        NavigationStack {
            List(dogs) { dog in
                NavigationLink(destination: DogDetailView(dog: dog)) {
                    Text(dog.name)
                }
            }
            .navigationTitle("My Dogs")
            .toolbar {
                Button(action: { showAddDogView = true }) {
                    Label("Add Dog", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showAddDogView) {
                AddDogView()
            }
        }
    }
}
