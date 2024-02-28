//
//  CreateJournalView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 13.02.2024.
//

import SwiftData
import SwiftUI

struct CreateJournalView: View {
    @Environment (\.modelContext) var modelContext
    @State private var numberOfQuestions = 0
    @Binding var journal: Journal
    @State private var showDatePicker = false
    @State private var showMoodView = false
    @Binding var sortNewestFirst: SortOrder
    @Binding var searchDate: Date

    let gradient = LinearGradient(gradient: Gradient(colors: [.pinkGradient, .purpleGradient]),
                                  startPoint: .top, endPoint: .bottom)

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
                    .buttonStyle(.bordered)
                    .tint(journal.mood.moodDetails.color)
                    .popover(isPresented: $showMoodView, attachmentAnchor: .point(.center)) {
                      MoodHistoryView(journal: $journal)
                            .padding()
                            .presentationCompactAdaptation(.popover)
                            .frame(minWidth: 300, minHeight: 250)
                    }
                }

                TextField("Title", text: $journal.title, prompt: Text("Title"))
                    .foregroundStyle(Color("Plantation"))
                    .font(
                        .system(size: 34, design: .rounded)
                        .weight(.heavy)
                    )
                ZStack {
                    TextEditor(text: $journal.content)
                        .scrollContentBackground(.hidden)

                    if $journal.wrappedValue.content.isEmpty {
                        VStack {
                            HStack {
                                Text("Start writing...")
                                    .foregroundStyle(.tertiary)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)

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
                                             journal: $journal,
                                             sortNewestFirst: $sortNewestFirst,
                                             searchDate: $searchDate)
                }
            }
            .sheet(isPresented: $showDatePicker) {
                    DatePickerSheetView(searchDate: $journal.date)
                        .presentationDetents([.fraction(0.7)])
                        .presentationBackground(.purpleGradient)
            }
            .background(gradient)
        }
    }
}

#Preview {
    CreateJournalView(journal: .constant(Journal.sampleData[0]),
                      sortNewestFirst: .constant(.forward),
                      searchDate: .constant(.now))
}
