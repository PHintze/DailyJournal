//
//  MoodEntry.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 09.02.2024.
//

import Foundation
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
