//
//  DatePickerSheetView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 16.02.2024.
//

import SwiftUI

struct DatePickerSheetView: View {
    @Binding var searchDate: Date

    @Environment(\.dismiss) var dismiss

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
                            .accessibilityIdentifier("SetDate")
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
                            .foregroundStyle(.indigo)
                            Spacer()
                        }
                    }
                }
                .tint(.indigo)
                .listSectionSpacing(10)
                .scrollContentBackground(.hidden)
            }
    }
}

#Preview {
    DatePickerSheetView(searchDate: .constant(.now))
}
