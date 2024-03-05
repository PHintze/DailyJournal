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
    @Environment(\.scenePhase) var scenePhase

    @State var journal: Journal?
    @State var sortNewestFirst: SortOrder = .reverse
    @State var searchDate: Date = Date()

    @StateObject private var securityController = SecurityController()

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var modelContainer: ModelContainer
    var network = Network()

    init() {
        do {
            let config = ModelConfiguration(for: Journal.self)
            modelContainer = try ModelContainer(for: Journal.self, configurations: config)
        } catch {
            fatalError("Failed to load model container.")
        }
    }

    var body: some Scene {
        WindowGroup {
            if securityController.isAppLockEnabled == true {
                if scenePhase == .active && UserDefaults.standard.bool(forKey: "isLocked") == false {
                    ContentView(journal: $journal,
                                sortNewestFirst: $sortNewestFirst,
                                searchDate: $searchDate)
                    .environmentObject(network)
                } else {
                    LockedView()
                }
            } else {
                ContentView(journal: $journal,
                            sortNewestFirst: $sortNewestFirst,
                            searchDate: $searchDate)
                .environmentObject(network)
            }
        }
        .modelContainer(modelContainer)
    }
}
