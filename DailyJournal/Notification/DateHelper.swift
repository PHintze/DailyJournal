//
//  DateHelper.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 28.02.2024.
//

import Foundation

struct DateHelper {
    // The universally used DateFormatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
