import SwiftUI
import SwiftData

struct HomePageView: View {
    @Query var dogs: [Dog]
    @State private var selectedDog: Dog? = nil
    @State private var currentMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var currentYear: Int = Calendar.current.component(.year, from: Date())
    


    private let calendar = Calendar.current

    var body: some View {
            NavigationView {
                // Scrollable Content
                ScrollView {
                    VStack(spacing: 20) {
                        // MARK: - Header Section
                        headerSection

                        // MARK: - Pet Details
                        if let dog = selectedDog {
                            petCardSection(for: dog)
                                .padding(.horizontal)

                            calendarNavigation

                            CalendarView(
                                month: currentMonth,
                                year: currentYear,
                                heatCycles: calculateEstrousStages(from: dog.lastCycleDate ?? Date()),
                                lastCycleDate: dog.lastCycleDate,
                                nextCycleDate: calendar.date(byAdding: .day, value: 28, to: dog.lastCycleDate ?? Date())
                            )
                            .padding(.horizontal)

                            menstrualDataCards(for: dog)
                                .padding(.horizontal)

                            heatCycleStages(for: dog)
                                .padding(.horizontal)
                        } else {
                            emptyStateView
                        }
                    }
                    .padding(.top, 10) // Adjusted to reduce extra spacing
                }
                .background(Color(UIColor.systemGroupedBackground))
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    if let firstDog = dogs.first {
                        updateSelectedDog(firstDog)
                    }
                }
            }
        }
    
    // MARK: - Menstrual Data Cards
    private func menstrualDataCards(for dog: Dog) -> some View {
        VStack(spacing: 10) {
            // Last Menstrual Period Card
            HStack(spacing: 15) {
                Image(systemName: "calendar")
                    .foregroundColor(Color(hex: "E1364A"))
                    .frame(width: 30, height: 30)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Last Menstrual Period")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(dog.lastCycleDate != nil
                        ? "\(dog.lastCycleDate!.formatted(date: .abbreviated, time: .omitted))"
                        : "Unknown")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)


            // Next Predicted Heat Cycle Card
            HStack(spacing: 15) {
                Image(systemName: "calendar.badge.clock")
                    .foregroundColor(Color(hex: "E1364A"))
                    .frame(width: 30, height: 30)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Next Predicted Heat Cycle")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("\(nextPredictedDate(from: dog.lastCycleDate ?? Date()))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)

        }
    }
    
    // MARK: - Next Predicted Date
    private func nextPredictedDate(from lastCycleDate: Date) -> String {
        let calendar = Calendar.current
        let nextDate = calendar.date(byAdding: .day, value: 28, to: lastCycleDate) ?? Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: nextDate)
    }



    // MARK: - Header Section with Dynamic Pet Menu
    private var headerSection: some View {
        HStack {
            // Pet Selection Menu
            Menu {
                ForEach(dogs) { dog in
                    Button(action: {
                        updateSelectedDog(dog)
                    }) {
                        Label(dog.name, systemImage: "pawprint.fill")
                    }
                }
            } label: {
                HStack {
                    Text("Active Profiles: \(selectedDog?.name ?? "Select a Pet")")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            // Bell Icon with Notification Badge
            
        }
        .padding(.horizontal)
        .padding()
    }

    

    // MARK: - Pet Card Section
    private func petCardSection(for dog: Dog) -> some View {
        HStack(spacing: 15) {
            Image("dog_profile_picture") // Replace with actual image loading
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))

            VStack(alignment: .leading, spacing: 5) {
                Text(dog.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(dog.breed)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()
        }
        .padding()
        .background(Color.pink)
        .cornerRadius(15)
    }

    // MARK: - Heat Cycle Stages (Improved UI)
    private func heatCycleStages(for dog: Dog) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Dog's Heat Cycle Stages")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            ForEach(calculateStageDates(from: dog.lastCycleDate ?? Date()), id: \.stage) { stage in
                HStack {
                    Circle()
                        .fill(stage.color)
                        .frame(width: 15, height: 15)

                    VStack(alignment: .leading, spacing: 3) {
                        Text(stage.stage)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(stage.dateRange)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer() // Ensures content stretches to full width
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }

    // MARK: - Calendar Navigation
    private var calendarNavigation: some View {
        HStack {
            Button(action: { navigateMonth(by: -1) }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.pink)
            }

            Text("\(monthName(for: currentMonth)) \(currentYear)")
                .font(.title3)
                .fontWeight(.medium)

            Button(action: { navigateMonth(by: 1) }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.pink)
            }
        }
        .padding(.vertical)
    }

    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "pawprint.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            Text("No pets available")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding(.top, 50)
    }

    // MARK: - Helper Methods
    private func updateSelectedDog(_ dog: Dog) {
        selectedDog = dog
    }

    private func navigateMonth(by offset: Int) {
        if let newDate = calendar.date(byAdding: .month, value: offset, to: currentMonthDate()) {
            currentMonth = calendar.component(.month, from: newDate)
            currentYear = calendar.component(.year, from: newDate)
        }
    }

    private func monthName(for month: Int) -> String {
        let formatter = DateFormatter()
        return formatter.monthSymbols[month - 1]
    }

    private func currentMonthDate() -> Date {
        calendar.date(from: DateComponents(year: currentYear, month: currentMonth))!
    }

    private func calculateStageDates(from startDate: Date) -> [(stage: String, dateRange: String, color: Color)] {
        let proestrus = 7
        let estrus = 5
        let diestrus = 60
        let anestrus = 60

        let proestrusEnd = calendar.date(byAdding: .day, value: proestrus, to: startDate)!
        let estrusEnd = calendar.date(byAdding: .day, value: proestrus + estrus, to: startDate)!
        let diestrusEnd = calendar.date(byAdding: .day, value: proestrus + estrus + diestrus, to: startDate)!
        let anestrusEnd = calendar.date(byAdding: .day, value: proestrus + estrus + diestrus + anestrus, to: startDate)!

        return [
            ("Proestrus", "\(formattedDate(startDate)) - \(formattedDate(proestrusEnd))", .red),
            ("Estrus", "\(formattedDate(proestrusEnd)) - \(formattedDate(estrusEnd))", .pink),
            ("Diestrus", "\(formattedDate(estrusEnd)) - \(formattedDate(diestrusEnd))", .orange),
            ("Anestrus", "\(formattedDate(diestrusEnd)) - \(formattedDate(anestrusEnd))", .gray)
        ]
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}



