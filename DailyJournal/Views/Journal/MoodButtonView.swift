//
//  MoodButtonView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftData
import SwiftUI

struct MoodButtonView: View {
    @Binding var journal: Journal

    @Environment(\.dismiss) var dismiss

    let gridButtonLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: gridButtonLayout, spacing: 5) {
            ForEach(Mood.allCases) { item in
                Button {
                    journal.mood = item
                    dismiss()
                } label: {
                    Text(item.moodDetails.name)
                        .frame(minWidth: 75, minHeight: 25)
                }
                .buttonStyle(.bordered)
                .tint(item.moodDetails.color)
            }
        }
        .padding()
        .background(.clear)
    }
}

#Preview {
    MoodButtonView(journal: .constant(Journal.sampleData[0]))
}
