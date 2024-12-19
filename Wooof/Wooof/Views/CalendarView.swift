import SwiftUI

struct CalendarView: View {
    var month: Int
    var year: Int
    var heatCycles: [HeatCycle]
    var lastCycleDate: Date?
    var nextCycleDate: Date?

    @State private var selectedDate: Date? = nil
    @State private var showDetails = false
    private let calendar = Calendar.current

    var body: some View {
        VStack(spacing: 16) {
            // Days of the Week Header
            weekHeader

            // Calendar Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(generateDays(), id: \.self) { day in
                    dayCell(for: day)
                }
            }
            .padding(.horizontal)

            // Details Popup for Selected Date
            if let selectedDate = selectedDate, showDetails {
                detailsCard(for: selectedDate)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .padding(.vertical)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Week Header
    private var weekHeader: some View {
        HStack {
            ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                Text(day)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Day Cell
    @ViewBuilder
    private func dayCell(for day: Date?) -> some View {
        if let date = day {
            Text("\(calendar.component(.day, from: date))")
                .frame(width: 40, height: 40)
                .background(circleColor(for: date))
                .clipShape(Circle())
                .foregroundColor(circleColor(for: date) == .clear ? .primary : .white)
                .onTapGesture {
                    if circleColor(for: date) != .clear {
                        selectedDate = date
                        withAnimation {
                            showDetails.toggle()
                        }
                    }
                }
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
        } else {
            Text("") // Empty space
                .frame(width: 40, height: 40)
        }
    }

    // MARK: - Generate Days in Month
    private func generateDays() -> [Date?] {
        var days: [Date?] = []
        let startOfMonth = calendar.date(from: DateComponents(year: year, month: month))!
        let daysInMonth = calendar.range(of: .day, in: .month, for: startOfMonth)!.count
        let firstDay = calendar.component(.weekday, from: startOfMonth)

        days.append(contentsOf: Array(repeating: nil, count: firstDay - 1)) // Empty spaces
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(date)
            }
        }
        return days
    }

    // MARK: - Highlight Dates
    private func circleColor(for date: Date) -> Color {
        if heatCycles.contains(where: { calendar.isDate($0.startDate, inSameDayAs: date) }) {
            return Color.pink.opacity(0.7) // Heat Cycle
        } else if let lastCycle = lastCycleDate, calendar.isDate(lastCycle, inSameDayAs: date) {
            return Color.red.opacity(0.7) // Last Cycle
        } else if let nextCycle = nextCycleDate, calendar.isDate(nextCycle, inSameDayAs: date) {
            return Color.blue.opacity(0.7) // Next Predicted Cycle
        } else {
            return .clear
        }
    }

    // MARK: - Details Card
    @ViewBuilder
    private func detailsCard(for date: Date) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Details for \(formattedDate(date))")
                .font(.headline)
                .foregroundColor(.primary)

            if let heatCycle = heatCycles.first(where: { calendar.isDate($0.startDate, inSameDayAs: date) }) {
                Text("Stage: \(heatCycle.stage)")
                    .font(.subheadline)
                    .foregroundColor(.pink)
                Text("Symptoms: \(heatCycle.symptoms.joined(separator: ", "))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else if let lastCycle = lastCycleDate, calendar.isDate(lastCycle, inSameDayAs: date) {
                Text("Last Menstrual Period")
                    .font(.subheadline)
                    .foregroundColor(.red)
            } else if let nextCycle = nextCycleDate, calendar.isDate(nextCycle, inSameDayAs: date) {
                Text("Predicted Next Cycle")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            } else {
                Text("No data available for this date")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
    }

    // MARK: - Date Formatter
    private func formattedDate(_ date: Date) -> String {
        return DateHelper.mediumFormatter.string(from: date)
    }
}

