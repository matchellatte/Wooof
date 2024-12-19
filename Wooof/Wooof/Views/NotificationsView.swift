import SwiftUI

struct NotificationsView: View {
    @State private var notifications: [NotificationModel] = []
    @State private var isLoading: Bool = true

    var body: some View {
        VStack {
            // Header Section
            HStack {
                Text("Notifications")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding()

            // Content Section
            if isLoading {
                // Loading State
                VStack {
                    ProgressView("Loading notifications...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if notifications.isEmpty {
                // Empty State
                VStack(spacing: 15) {
                    Image(systemName: "bell.slash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray.opacity(0.6))
                    Text("No Notifications")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Notifications List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(notifications) { notification in
                            NotificationRow(notification: notification)
                                .transition(.move(edge: .top))
                        }
                    }
                    .padding()
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .onAppear {
            fetchNotifications()
        }
    }

    // MARK: - Fetch Notifications
    private func fetchNotifications() {
        isLoading = true

        // Replace this block with your real fetch logic
        DispatchQueue.global().async {
            // Simulating network fetch
            sleep(2) // Simulate network delay

            // Replace this with actual API or database fetching
            let fetchedNotifications = [
                NotificationModel(id: 1, title: "Reminder", description: "Luna's next heat cycle starts soon!", timestamp: "Dec 20, 2024"),
                NotificationModel(id: 2, title: "Adoption Success", description: "Congratulations! Your pet adoption is successful.", timestamp: "Dec 18, 2024"),
                NotificationModel(id: 3, title: "Health Update", description: "A new vaccine update is available for Luna.", timestamp: "Dec 17, 2024")
            ]

            DispatchQueue.main.async {
                self.notifications = fetchedNotifications
                self.isLoading = false
            }
        }
    }
}

struct NotificationRow: View {
    let notification: NotificationModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text(notification.title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            // Description
            Text(notification.description)
                .font(.subheadline)
                .foregroundColor(.gray)

            // Timestamp
            Text(notification.timestamp)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color(UIColor.systemGray6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Notification Model
struct NotificationModel: Identifiable {
    let id: Int
    let title: String
    let description: String
    let timestamp: String
}

#Preview {
    NotificationsView()
}
