import SwiftUI

struct ProfileView: View {
    @State private var userName = "Loading..." // Placeholder for user name
    @State private var userEmail = "Loading..." // Placeholder for email
    @State private var navigateToLogin = false // Controls navigation to LoginPage

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Profile Picture
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(Color(hex: "E1364A"))

                // User Info
                VStack(spacing: 10) {
                    Text(userName) // Dynamic user name
                        .font(.title)
                        .fontWeight(.bold)

                    Text(userEmail) // Dynamic email
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Divider() // Visual separator

                // Account Options
                VStack(spacing: 15) {
                    ProfileOptionRow(icon: "gear", label: "Settings")
                    ProfileOptionRow(icon: "bell", label: "Notifications")
                    ProfileOptionRow(icon: "lock", label: "Privacy Policy")
                    ProfileOptionRow(icon: "questionmark.circle", label: "Help & Support")
                }

                Spacer()

                // Logout Button
                Button(action: logout) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "E1364A"))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .navigationDestination(isPresented: $navigateToLogin) {
                    LoginPage()
                }
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: fetchUserData) // Fetch user data when the view appears
        }
    }

    // Function to fetch user data
    private func fetchUserData() {
        Task {
            do {
                let session = try await SupabaseConfig.shared.client.auth.session
                let user = session.user

                if let fullNameJSON = user.userMetadata["full_name"],
                   case let .string(fullName) = fullNameJSON {
                    self.userName = fullName
                } else {
                    self.userName = "Grechelle Ann"
                }

                self.userEmail = user.email ?? "No Email Available"
            } catch {
                print("Failed to fetch user data: \(error)")
                self.userName = "Error"
                self.userEmail = "Error"
            }
        }
    }

    // Function to handle logout
    private func logout() {
        Task {
            do {
                try await SupabaseConfig.shared.client.auth.signOut()
                navigateToLogin = true // Navigate to login page after logout
            } catch {
                print("Logout failed: \(error)")
            }
        }
    }
}

// Reusable Row Component
struct ProfileOptionRow: View {
    var icon: String
    var label: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Color(hex: "E1364A"))
                .frame(width: 30) // Align icons consistently

            Text(label)
                .font(.headline)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
