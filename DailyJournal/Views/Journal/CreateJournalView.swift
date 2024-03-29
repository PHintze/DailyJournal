//
//  CreateJournalView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 13.02.2024.
//

import SwiftData
import SwiftUI

struct CreateJournalView: View {
    @Binding var journal: Journal

    @State private var showDatePicker = false
    @State private var showMoodView = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    HStack {
                        Text("\(journal.date.formatted(.dateTime.day()))")
                            .font(.title)
                            .bold()
                            .underline()
                        VStack {
                            Text("\(journal.date.formatted(.dateTime.month().year()))")
                            Text("\(journal.date.formatted(.dateTime.weekday(.wide)))")
                        }
                    }

                    Spacer()

                    Button {
                        showMoodView.toggle()
                    } label: {
                        Text((journal.mood.moodDetails.name))

                    }
                    .accessibilityIdentifier("MoodButton")
                    .accessibilityLabel("Change mood")
                    .buttonStyle(.bordered)
                    .tint(journal.mood.moodDetails.color)
                    .popover(isPresented: $showMoodView, attachmentAnchor: .point(.center)) {
                        MoodHistoryView(journal: $journal)
                            .padding()
                            .presentationCompactAdaptation(.popover)
                            .frame(minWidth: 300, minHeight: 250)
                            .background(.darkPurpleGradient)
                    }
                }

                TextField("Title", text: $journal.title, prompt: Text("Title"))
                    .foregroundStyle(.accent)
                    .font(
                        .system(size: 34, design: .rounded)
                        .weight(.heavy)
                    )
                    .accessibilityLabel("Enter title")
                ZStack {
                    TextEditor(text: $journal.content)
                        .scrollContentBackground(.hidden)
                        .accessibilityIdentifier("Content")
                        .accessibilityHidden(false)

                    if $journal.wrappedValue.content.isEmpty {
                        VStack {
                            HStack {
                                Text("Start writing...")
                                    .foregroundStyle(.tertiary)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                                    .accessibilityLabel("Start writing")

                                Spacer()
                            }

                            Spacer()
                        }
                    }
                }

                Spacer()

            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CreateJournalToolbarView(showDatePicker: $showDatePicker,
                                             journal: $journal)
                }
            }
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheetView(searchDate: $journal.date)
                    .presentationDetents([.fraction(0.7)])
                    .presentationBackground(.clear)
            }
            .background(Background.gradient)
        }
    }
}

#Preview {
    CreateJournalView(journal: .constant(Journal.sampleData[0]))
}
