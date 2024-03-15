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
                let container = try ModelContainer(for: Journal.self, configurations: config)

                for number in 1...7 {
                    let journalEntry = Journal.sampleData[number]
                    container.mainContext.insert(journalEntry)
                }

                return container
            } catch {
                fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
            }
        }()
}
