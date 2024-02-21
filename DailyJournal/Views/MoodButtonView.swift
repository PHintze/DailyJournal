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

    let gridButtonLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            LazyVGrid(columns: gridButtonLayout, spacing: 10) {
                ForEach(Mood.allCases) { item in
                    Button {
                        let newEntry = MoodEntry(date: .now, mood: item)
                        modelContext.insert(newEntry)
                    } label: {
                        Text(item.moodDetails.name)
                            .frame(minWidth: 100, minHeight: 50)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .tint(item.moodDetails.color)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MoodButtonView()
}
