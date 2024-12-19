//
//  CalendarNavigationView.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation
import SwiftUI

struct CalendarNavigationView: View {
    @Binding var currentMonth: Int
    @Binding var currentYear: Int
    let calendar: Calendar

    var body: some View {
        HStack {
            Button(action: { navigateMonth(by: -1) }) {
                Image(systemName: "chevron.left").foregroundColor(.pink)
            }

            Text("\(monthName(for: currentMonth)) \(currentYear)")
                .font(.title3)

            Button(action: { navigateMonth(by: 1) }) {
                Image(systemName: "chevron.right").foregroundColor(.pink)
            }
        }
        .padding(.vertical)
    }

    private func navigateMonth(by offset: Int) {
        if let newDate = calendar.date(byAdding: .month, value: offset, to: Date()) {
            currentMonth = calendar.component(.month, from: newDate)
            currentYear = calendar.component(.year, from: newDate)
        }
    }

    private func monthName(for month: Int) -> String {
        DateFormatter().monthSymbols[month - 1]
    }
}

