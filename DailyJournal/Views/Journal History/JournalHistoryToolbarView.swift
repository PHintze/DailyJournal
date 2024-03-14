//
//  JournalHistoryToolbarView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 16.02.2024.
//

import SwiftUI

struct JournalHistoryToolbarView: View {
    @Binding var searchDate: Date
    @Binding var sortNewestFirst: SortOrder

    @Environment(\.modelContext) var modelContext

    @State private var showDatePicker = false

    var body: some View {
        HStack {
            Menu {
                Button("Search by Date") {
                    showDatePicker.toggle()
                }
                Picker("Sort Order", selection: $sortNewestFirst) {
                    Text("Newest to Oldest").tag(SortOrder.reverse)
                    Text("Oldest to Newest").tag(SortOrder.forward)
                }
            } label: {
                Label("Menu", systemImage: "line.3.horizontal.decrease.circle")
                    .symbolVariant(searchDate.formatted(date: .abbreviated, time: .omitted) !=
                                   Date().formatted(date: .abbreviated, time: .omitted) ? .fill : .none)

            }
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheetView(searchDate: $searchDate)
                    .presentationDetents([.fraction(0.7)])
                    .presentationBackground(.clear)
            }
#if DEBUG
            Button {
                do {
                    try modelContext.delete(model: Journal.self)
                    for selectedJournal in Journal.sampleData {
                        modelContext.insert(selectedJournal)
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

#Preview {
    JournalHistoryToolbarView(searchDate: .constant(.now), sortNewestFirst: .constant(SortOrder.forward))
}
