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

    var body: some View {
        VStack {
            if numberOfQuestions == 0 {
                Text("Show current date or can select a entry date")
                MoodHistoryView()
            } else {
                if journalQuestions.contains(where: {$0.id == numberOfQuestions}) {
                    Text(journalQuestions[numberOfQuestions].text)
                        .foregroundStyle(Color("Plantation"))
                        .font(
                            .system(size: 34, design: .rounded)
                            .weight(.heavy)
                            )
                    TextField("Answer:",
                              text: $journal.questions[numberOfQuestions].answer,
                              prompt: Text("Enter your answer here:"),
                              axis: .vertical)
                    .frame(minHeight: 100)
                    .padding()
                } else {
                    Text("Finished")
                }
            }
            Button {
                if numberOfQuestions == 3 {
                    modelContext.insert(journal)
                } else {
                    numberOfQuestions += 1
                }
            } label: {
                if numberOfQuestions == 3 {
                    Text("Finish Journal")
                } else {
                    Text("Next Question")
                }
            }
            .padding()
        }
    }
}

#Preview {
    CreateJournalView(journal: .constant(Journal.sampleData[0]))
}
