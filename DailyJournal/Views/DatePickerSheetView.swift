//
//  DatePickerSheetView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 16.02.2024.
//

import SwiftUI

struct DatePickerSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchDate: Date

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack {
                        HStack {
                            Label("Select Date", systemImage: "calendar")
                                .labelStyle(.titleAndIcon)
                                .bold()
                            Spacer()
                        }
                        DatePicker("Enter date", selection: $searchDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)

                        Divider()

                        Button("Done") {
                            dismiss()
                        }
                        .bold()

                    }
                }

                Section {
                    HStack {
                        Spacer()
                        Button("Cancel") {
                            searchDate = .now
                            dismiss()
                        }
                        .bold()
                        Spacer()
                    }
                }
            }
            .listSectionSpacing(10)
        }
    }
}

#Preview {
    DatePickerSheetView(searchDate: .constant(.now))
}
