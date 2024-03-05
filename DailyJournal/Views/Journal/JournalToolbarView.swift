//
//  JournalToolbarView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 05.03.2024.
//

import SwiftUI

struct JournalToolbarView: View {
    @Binding var journal: Journal

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @Binding var showDatePicker: Bool
    @Binding var showMoodView: Bool

    var body: some View {
            HStack {
                Menu {
                    Button("Change Date") {
                        showDatePicker.toggle()
                    }
                    Button(role: .destructive) {
                        modelContext.delete(journal)
                        dismiss()
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

#Preview {
    JournalToolbarView(journal: .constant(Journal.sampleData[0]),
                       showDatePicker: .constant(false),
                       showMoodView: .constant(false))
}
