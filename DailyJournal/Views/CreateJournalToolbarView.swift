//
//  CreateJournalToolbarView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 21.02.2024.
//

import SwiftData
import SwiftUI

struct RedBorderMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .border(Color.red)
            .foregroundStyle(.green)
    }
}

struct CreateJournalToolbarView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Binding var showDatePicker: Bool
    @Binding var journal: Journal
    @Binding var sortNewestFirst: SortOrder
    @Binding var searchDate: Date

    var body: some View {
        NavigationStack {
            HStack {
                Menu {
                    Button("Custom Date") {
                        showDatePicker.toggle()
                    }
                    Button(role: .destructive) {
                        modelContext.delete(journal)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                } label: {
                    Label("Sort", systemImage: "ellipsis.circle")
                        .labelStyle(.iconOnly)
                }

                Button {
                    // updating the formatted date of the journal to the journal date so that the search
                    // in the history view is working correctly
                    journal.formattedDate = journal.date.formatted(date: .abbreviated, time: .omitted)
                    dismiss()
                } label: {
                    Text("Done")
                        .bold()
                }
            }
        }
    }
}

#Preview {
    CreateJournalToolbarView(showDatePicker: .constant(false),
                             journal: .constant(Journal.sampleData[0]),
                             sortNewestFirst: .constant(.forward),
                             searchDate: .constant(.now))
}
