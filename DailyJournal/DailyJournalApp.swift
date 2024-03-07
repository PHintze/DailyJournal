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
    @State var quote: Quote = .default

    @StateObject private var securityController = SecurityController()

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var modelContainer: ModelContainer

    var currentDateFormatted = Date().formatted(date: .abbreviated, time: .omitted)
    let defaults = UserDefaults.standard

    init() {
        var inMemory = false

        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            inMemory = true
            UIView.setAnimationsEnabled(false)
        }
        #endif

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
                    .environmentObject(quote)
                } else {
                    LockedView()
                }
            } else {
                ContentView(journal: $journal,
                            sortNewestFirst: $sortNewestFirst,
                            searchDate: $searchDate)
                .environmentObject(quote)
            }
        }
        .modelContainer(modelContainer)
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .background, .inactive:
                break
            case .active:
                Task {
                    if currentDateFormatted != defaults.string(forKey: "LastRun") {
                        if let quote = await RandomQuoteAPI.getRandomQuote() {
                            self.quote = quote
                            defaults.setValue(quote.author, forKey: "LastQuoteAuthor")
                            defaults.setValue(quote.content, forKey: "LastQuoteContent")
                            defaults.setValue(currentDateFormatted, forKey: "LastRun")
                        }
                    }
                }
            @unknown default:
                break
            }
        }
    }
}
