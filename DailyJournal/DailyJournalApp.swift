//
//  DailyJournalApp.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftData
import SwiftUI

@main
struct DailyJournalApp: App {
    var modelContainer: ModelContainer
    @State var moodHistory: [MoodEntry]?
    @State var journal: Journal?
    @State var sortNewestFirst: SortOrder = .reverse
    @State var searchDate: Date = Date()

    var network = Network()

    init() {
        do {
            let config = ModelConfiguration(for: MoodEntry.self, Journal.self)
            modelContainer = try ModelContainer(for: MoodEntry.self, Journal.self, configurations: config)
        } catch {
            fatalError("Failed to load model container.")
        }
    }

    var body: some Scene {
        WindowGroup {
                ContentView(moodHistory: moodHistory,
                            journal: $journal,
                            sortNewestFirst: $sortNewestFirst,
                            searchDate: $searchDate)
                .environmentObject(network)
            }
        .modelContainer(modelContainer)
    }
}
