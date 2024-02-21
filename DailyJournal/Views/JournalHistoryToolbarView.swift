//
//  JournalHistoryToolbarView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 16.02.2024.
//

import SwiftUI

struct JournalHistoryToolbarView: View {
    @Binding var searchDate: Date
    @State private var showDatePicker = false
    @Binding var sortNewestFirst: SortOrder

    var body: some View {

        Menu {
            Button("Search by Date") {
                showDatePicker.toggle()
            }
            Picker("Sort Order", selection: $sortNewestFirst) {
                Text("Newest to Oldest").tag(SortOrder.reverse)
                Text("Oldest to Newest").tag(SortOrder.forward)
            }
        } label: {
            Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerSheetView(searchDate: $searchDate)
                .presentationDetents([.fraction(0.7)])
        }
    }
}

#Preview {
    JournalHistoryToolbarView(searchDate: .constant(.now), sortNewestFirst: .constant(SortOrder.forward))
}
