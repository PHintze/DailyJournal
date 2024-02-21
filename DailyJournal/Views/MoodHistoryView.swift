//
//  MoodHistoryView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 09.02.2024.
//

import SwiftData
import SwiftUI

struct MoodHistoryView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \MoodEntry.date, order: .reverse) var moodHistory: [MoodEntry]

    var body: some View {
        NavigationStack {
            Text("How are you feeling today?")
                .foregroundStyle(Color("Plantation"))
                .font(
                    .system(size: 34, design: .rounded)
                    .weight(.heavy)
                )

            MoodButtonView()

//            Text("History")
//                .foregroundStyle(Color("Plantation"))
//                .font(
//                    .system(size: 34, design: .rounded)
//                    .weight(.heavy)
//                )
//
//            List {
//                ForEach(moodHistory) { item in
//                    HStack {
//                        Text("\(String(describing: item.date.formatted(date: .long, time: .omitted)))")
//                        Spacer()
//                        Text("\(item.mood.rawValue)")
//                    }
//                }
//                .onDelete(perform: delete)
//            }
//            .listStyle(.plain)
        }
        .padding()

    }
    func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let item = moodHistory[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    MoodHistoryView()
        .modelContainer(PreviewSampleData.previewContainer)
}
