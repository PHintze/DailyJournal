//
//  MoodEntry.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 09.02.2024.
//

import Foundation
import SwiftData
import SwiftUI

enum Mood: String, Codable, CaseIterable, Identifiable, RawRepresentable {
    case awesome = "Awesome"
    case happy = "Happy"
    case okay = "Okay"
    case bad = "Bad"
    case terrible = "Terrible"

    var id: String { self.rawValue }

    var moodDetails: (name: String, color: Color) {
        switch self {
        case .awesome:
            return ("Awesome", .green)
        case .happy:
            return ("Happy", .green)
        case .okay:
            return ("Okay", .blue)
        case .bad:
            return ("Bad", .red)
        case .terrible:
            return ("Terrible", .red)
        }
    }
}

@Model
class MoodEntry: Identifiable {
    var date: Date
    var mood: Mood
    var id: UUID

    init(date: Date, mood: Mood, id: UUID = UUID()) {
        self.date = date
        self.mood = mood
        self.id = id
    }
}

extension MoodEntry {
    static let moodHistorySampleData: [MoodEntry] =
    [
        MoodEntry(date: .now, mood: .awesome),
        MoodEntry(date: .now - 1, mood: .happy),
        MoodEntry(date: .now - 2, mood: .okay),
        MoodEntry(date: .now - 3, mood: .bad),
        MoodEntry(date: .now - 4, mood: .terrible)
    ]
}
