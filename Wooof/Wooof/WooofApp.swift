import SwiftUI
import SwiftData

@main
struct WooofApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Dog.self,
            HeatCycle.self
        ])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GetStartedView() // Entry point
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
