//
//  Journal.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Journal: Identifiable {
    var date: Date
    var formattedDate: String
    var mood: Mood
    var title: String
    var content: String
    var id: UUID

    init(date: Date, mood: Mood = .awesome, title: String, content: String, id: UUID = UUID()) {
        self.date = date
        self.formattedDate = date.formatted(date: .abbreviated, time: .omitted)
        self.mood = mood
        self.title = title
        self.content = content
        self.id = id
    }
}

extension Journal {
    static let sampleData: [Journal] =
    [
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                mood: .awesome,
               title: "My first journal",
               content: """
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut
                labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores
                et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                """),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                mood: .bad,
                title: "My first journal",
                content: """
                 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut
                 labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores
                 et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                 """),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                mood: .happy,
                title: "My first journal",
                content: """
                 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut
                 labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores
                 et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                 """),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                mood: .awesome,
                title: "My first journal",
                content: """
                 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut
                 labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores
                 et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                 """),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                mood: .bad,
                title: "My first journal",
                content: """
                 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut
                 labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores
                 et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                 """),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                mood: .happy,
                title: "My first journal",
                content: """
                 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut
                 labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores
                 et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                 """)
    ]
}
extension Journal {
    static func predicate(searchDate: Date) -> Predicate<Journal> {
        let formattedSearchDate = searchDate.formatted(date: .abbreviated, time: .omitted)

        if formattedSearchDate == Date().formatted(date: .abbreviated, time: .omitted) {
            return #Predicate<Journal> { _ in
                true
            }
        } else {
            return #Predicate<Journal> { journal in
                journal.formattedDate == formattedSearchDate
            }
        }
    }
}
