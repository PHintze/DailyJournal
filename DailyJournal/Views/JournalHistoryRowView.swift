//
//  JournalHistoryRow.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 23.02.2024.
//

import SwiftUI

struct JournalHistoryRow: View {
    @Environment(\.modelContext) var modelContext
    @Binding var showJournalDetailEditView: Bool

    @Bindable var journal: Journal
    @Binding var selectedJournal: Journal

    var body: some View {
        NavigationStack {
            NavigationLink(value: journal) {
                VStack {
                    HStack {
                        Text("\(journal.date.formatted(.dateTime.day()))")
                            .font(.title)
                            .bold()
                            .underline()
                        Text("\(journal.date.formatted(.dateTime.weekday(.abbreviated))),")
                        Text("\(journal.date.formatted(.dateTime.month().year()))")

                        Spacer()
                        ZStack {
                        }
                        .frame(width: 85, height: 35)
                        .background(journal.mood.moodDetails.color)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .opacity(0.3)
                        .overlay {
                            Text(journal.mood.moodDetails.name)
                                .foregroundStyle(journal.mood.moodDetails.color)
                        }
                    }

                    VStack(alignment: .leading) {
                        Text(journal.title)
                            .font(
                                .system(size: 22, design: .rounded)
                                .weight(.heavy)
                            )
                            .foregroundStyle(.accent)
                        Text(journal.content)
                    }
                    HStack {
                        Spacer()
                        Menu {
                            Button {
                                selectedJournal = journal
                                showJournalDetailEditView.toggle()
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            Button(role: .destructive) {
                                modelContext.delete(journal)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        } label: {
                            Label("Edit", systemImage: "ellipsis")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
                .navigationDestination(for: Journal.self) { journal in
                    JournalDetailView(journal: journal)
                }
            }
        }
        .padding()
        .frame(maxHeight: 175)
    }
}

#Preview {
    JournalHistoryRow(showJournalDetailEditView: .constant(false),
                      journal: Journal.sampleData[0],
                      selectedJournal: .constant(Journal.sampleData[0]))
}
