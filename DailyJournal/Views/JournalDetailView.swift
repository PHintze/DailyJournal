//
//  JournalDetailView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 16.02.2024.
//

import SwiftUI

struct JournalDetailView: View {
    let journal: Journal

    let gradient = LinearGradient(gradient: Gradient(colors: [.pinkGradient, .purpleGradient]),
                                  startPoint: .top, endPoint: .bottom)

    var body: some View {
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
                    Text(journal.mood.moodDetails.name)
                        .foregroundStyle(journal.mood.moodDetails.color)
                }
            }

            Text(journal.title)
                .foregroundStyle(.accent)
                .font(
                    .system(size: 34, design: .rounded)
                    .weight(.heavy)
                )

            HStack {
                Text(journal.content)
                Spacer()
            }
            Spacer()
        }
        .padding()
        .background(gradient)
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    JournalDetailView(journal: Journal.sampleData[0])
}
