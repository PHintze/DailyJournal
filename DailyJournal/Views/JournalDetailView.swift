//
//  JournalDetailView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 16.02.2024.
//

import SwiftUI

struct JournalDetailView: View {
    var journal: Journal

    var body: some View {
        Text("Date: \(journal.date)")
        Text("Question 1: \(journal.questions[0].text)")
        Text("Answer 1: \(journal.questions[0].answer)")

        Text("Question 2: \(journal.questions[1].text)")
        Text("Answer 2: \(journal.questions[1].answer)")

        Text("Question 3: \(journal.questions[2].text)")
        Text("Answer 3: \(journal.questions[2].answer)")

        Text("Question 4: \(journal.questions[3].text)")
        Text("Answer 4: \(journal.questions[3].answer)")

        Text("Question 5: \(journal.questions[4].text)")
        Text("Answer 5: \(journal.questions[4].answer)")

        Text("Question 6: \(journal.questions[5].text)")
        Text("Answer 6: \(journal.questions[5].answer)")

    }
}

#Preview {
    JournalDetailView(journal: Journal.sampleData[0])
}
