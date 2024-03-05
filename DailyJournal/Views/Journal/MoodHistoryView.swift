//
//  MoodHistoryView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 09.02.2024.
//

import SwiftData
import SwiftUI

struct MoodHistoryView: View {
    @Binding var journal: Journal

    var body: some View {
        VStack {
            Text("How are you feeling today?")
                .foregroundStyle(.accent)
                .font(
                    .system(size: 17, design: .rounded)
                    .weight(.heavy)
                )
            MoodButtonView(journal: $journal)
        }
        .padding()
    }
}

#Preview {
    MoodHistoryView(journal: .constant(Journal.sampleData[0]))
        .modelContainer(PreviewSampleData.previewContainer)
}
