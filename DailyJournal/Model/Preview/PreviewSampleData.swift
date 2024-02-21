//
//  PreviewSampleData.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 11.02.2024.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class PreviewSampleData {
    static let previewContainer: ModelContainer = {
            do {
                let config = ModelConfiguration(isStoredInMemoryOnly: true)
                let container = try ModelContainer(for: MoodEntry.self, Journal.self, configurations: config)

                for number in 1...7 {
                    let moodEntry = MoodEntry(date: .now - TimeInterval(number), mood: .allCases.randomElement()!)
                    container.mainContext.insert(moodEntry)
                }

                for number in 1...7 {
                    let journalEntry = Journal.sampleData[number]
//
//                    Journal(
//                        day: .now,
//                        questions: [
//                            Journal.Question(text: "I am grateful for...", answer: ""),
//                            Journal.Question(text: "This is how I will make today great", answer: ""),
//                            Journal.Question(text: "Positive affirmation", answer: ""),
//                            Journal.Question(text: "My good dead today", answer: ""),
//                            Journal.Question(text: "How I will improve", answer: ""),
//                            Journal.Question(text: "Great things I experienced today", answer: "")
//                        ],
//                        mood: .awesome)
                    container.mainContext.insert(journalEntry)
                }

                return container
            } catch {
                fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
            }
        }()
}
