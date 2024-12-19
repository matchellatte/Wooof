//
//  DateHelper.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation

struct DateHelper {
    static let mediumFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

