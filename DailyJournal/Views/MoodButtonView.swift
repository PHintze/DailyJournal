//
//  MoodButtonView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftData
import SwiftUI

struct MoodButtonView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var journal: Journal

    let gridButtonLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: gridButtonLayout, spacing: 5) {
            ForEach(Mood.allCases) { item in
                Button {
                    let newEntry = MoodEntry(date: .now, mood: item)
                    journal.mood = newEntry.mood
                    modelContext.insert(newEntry)
                } label: {
                    Text(item.moodDetails.name)
                        .frame(minWidth: 75, minHeight: 25)
                }
                .buttonStyle(.bordered)
                .tint(item.moodDetails.color)
            }
        }
        .padding()
        .background(.listRow)
    }
}

#Preview {
    MoodButtonView(journal: .constant(Journal.sampleData[0]))
}
