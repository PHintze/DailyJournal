//
//  JournalHistoryView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftData
import SwiftUI
import LocalAuthentication

struct JournalHistoryView: View {
    @Binding var sortNewestFirst: SortOrder
    @Binding var searchDate: Date
    @Binding var selectedJournal: Journal

    @State var showJournalDetailEditView = false

    @Query var journals: [Journal]

    init(sortNewestFirst: Binding<SortOrder>, searchDate: Binding<Date>, selectedJournal: Binding<Journal>) {
        self._sortNewestFirst = sortNewestFirst
        self._searchDate = searchDate
        self._selectedJournal = selectedJournal
        _journals = Query(filter: Journal.predicate(searchDate: $searchDate.wrappedValue),
                          sort: \Journal.date,
                          order: self.sortNewestFirst)

        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.accent]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.accent]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Background.gradient
                    .ignoresSafeArea()
                VStack {
                    if journals.count == 0 {
                        Text("No journals found.")
                            .font(.title)
                            .foregroundStyle(.secondary)
                            .toolbar {
                                JournalHistoryToolbarView(searchDate: $searchDate,
                                                          sortNewestFirst: $sortNewestFirst)
                            }
                    } else {
                        List {
                            ForEach(journals) { journal in
                                JournalHistoryRow(journal: journal,
                                                  showJournalDetailEditView: $showJournalDetailEditView,
                                                  selectedJournal: $selectedJournal)
                            }
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(.ultraThinMaterial)
                            )
                        }
                        .listRowSpacing(25)
                        .listStyle(.plain)
                        .padding()
                        .accessibilityIdentifier("JournalList")

                        .sheet(isPresented: $showJournalDetailEditView) {
                            JournalDetailEditView(journal: $selectedJournal)
                        }

                    }
                }
                .navigationTitle("DailyJournal")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    JournalHistoryView(sortNewestFirst: .constant(.forward),
                       searchDate: .constant(.now),
                       selectedJournal: .constant(Journal.sampleData[0])
    )
    .modelContainer(PreviewSampleData.previewContainer)
}
