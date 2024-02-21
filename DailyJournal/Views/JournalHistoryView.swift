//
//  JournalHistoryView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftData
import SwiftUI

struct JournalHistoryView: View {
    @Environment (\.modelContext) var modelContext
    @Query var journals: [Journal]
    @Binding var sortNewestFirst: SortOrder
    @Binding var searchDate: Date

    init(sortNewestFirst: Binding<SortOrder>, searchDate: Binding<Date>) {

        self._sortNewestFirst = sortNewestFirst
        self._searchDate = searchDate
        _journals = Query(filter: Journal.predicate(searchDate: $searchDate.wrappedValue),
                          sort: \Journal.date,
                          order: self.sortNewestFirst)
    }

    var body: some View {
        NavigationStack {
            if journals.isEmpty {
                Text("No journals found.")
                    .font(.title)
                    .foregroundStyle(.secondary)
                    .toolbar {
                        JournalHistoryToolbarView(searchDate: $searchDate, sortNewestFirst: $sortNewestFirst)
                    }
            } else {
                List {
                    ForEach(journals) { journal in
                        NavigationLink(destination: JournalDetailView(journal: journal)) {
                            VStack {
                                HStack {
                                    VStack {
                                        HStack {
                                            Image(systemName: "calendar")
                                            Text("\(journal.date.formatted(date: .long, time: .omitted))")
                                                .font(.title3)
                                        }
                                        Text(journal.questions[0].text)
                                            .font(.headline)
                                        Text(journal.questions[0].answer)
                                    }
                                    Spacer()
                                    Text(journal.mood?.rawValue ?? "")
                                        .foregroundStyle(.black)
                                        .background(journal.mood?.moodDetails.color ?? .white)
                                }
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    .navigationTitle("Journals")
                }
                .toolbar {
                    JournalHistoryToolbarView(searchDate: $searchDate, sortNewestFirst: $sortNewestFirst)
#if DEBUG
                    Button {
                        do {
                            try modelContext.delete(model: Journal.self)
                            for journal in Journal.sampleData {
                                modelContext.insert(journal)
                            }
                        } catch {
                            print("Failed to delete journal data.")
                        }
                    } label: {
                        Label("Add Samples", systemImage: "flame")
                    }
#endif
                }
            }

        }
    }

    func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let item = journals[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    JournalHistoryView(sortNewestFirst: .constant(.forward), searchDate: .constant(.now))
        .modelContainer(PreviewSampleData.previewContainer)
}
