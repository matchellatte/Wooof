import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationStack { // Single navigation stack at root
            TabView {
                HomePageView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                MyPetsView()
                    .tabItem {
                        Label("My Pets", systemImage: "pawprint")
                    }

                DogEstrousCycleView()
                    .tabItem {
                        Label("Woof", systemImage: "pawprint.circle") // Changed icon to avoid duplicate
                    }

                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
            .accentColor(.pink)
            .navigationBarBackButtonHidden(true) // Hides the back button globally
        }
    }
}
