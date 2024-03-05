//
//  JournalDetailEditView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 24.02.2024.
//

import SwiftUI

struct JournalDetailEditView: View {
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

                    ZStack {
                    }
                    .frame(width: 85, height: 35)
                    .background(journal.mood.moodDetails.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    .opacity(0.3)
                    .overlay {
                        Button {
                            showMoodView.toggle()
                        } label: {
                            Text((journal.mood.moodDetails.name))
                                .foregroundStyle(journal.mood.moodDetails.color)

                        }
                        .popover(isPresented: $showMoodView, attachmentAnchor: .point(.center)) {
                            MoodHistoryView(journal: $journal)
                                .padding()
                                .presentationCompactAdaptation(.popover)
                                .frame(minWidth: 300, minHeight: 250)
                                .background(.darkPurpleGradient)
                        }

                    }
                }

                TextField("Title", text: $journal.title, prompt: Text("Enter title here"))
                    .foregroundStyle(.accent)
                    .font(
                        .system(size: 34, design: .rounded)
                        .weight(.heavy)
                    )

                ZStack(alignment: .leading) {
                    if journal.content.isEmpty {
                        VStack {
                            Text("Start writing...")
                                .scrollContentBackground(.hidden)
                                .opacity(0.6)
                                .padding(.top, 10)
                                .padding(.leading, 6)
                            Spacer()
                        }
                    }
                    VStack {
                        TextEditor(text: $journal.content)
                            .scrollContentBackground(.hidden)
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding()
            .background(Background.gradient)

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                   JournalToolbarView(journal: $journal, showDatePicker: $showDatePicker, showMoodView: $showMoodView)
                }
            }
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheetView(searchDate: $journal.date)
                    .presentationDetents([.fraction(0.7)])
                    .presentationBackground(.clear)
            }
        }
    }
}

#Preview {
    JournalDetailEditView(journal: .constant(Journal.sampleData[0]))
}
