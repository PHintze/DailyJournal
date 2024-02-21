//
//  ContentView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var quote: Quote?
    @State var moodHistory: [MoodEntry]?
    @Binding var journal: Journal?
    @Binding var sortNewestFirst: SortOrder
    @Binding var searchDate: Date

    var journalBinding: Binding<Journal> {
        .init(get: { journal ?? Journal(date: .now, questions: journalQuestions, mood: nil)},
              set: { journal = $0 })
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                HomeView(journal: $journal)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                JournalHistoryView(sortNewestFirst: $sortNewestFirst, searchDate: $searchDate)
                    .tabItem {
                        Label("Journals", systemImage: "calendar.badge.clock.rtl")
                    }
            }
            .labelStyle(.iconOnly)

            NavigationLink {
                CreateJournalView(journal: journalBinding)
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
            }
            .frame(width: 50, height: 50)
            .background(Color(.plantation))
            .clipShape(Circle())
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    ContentView(quote: .constant(Quote(id: UUID(), content: "Content", author: "Author")),
                moodHistory: MoodEntry.moodHistorySampleData, journal: .constant(Journal.sampleData[0]),
                sortNewestFirst: .constant(SortOrder.forward), searchDate: .constant(.now))
}
