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
class Journal {
    var date: Date
    var formattedDate: String
    var questions: [Question]
    var mood: Mood?

    init(date: Date, questions: [Question], mood: Mood? = nil) {
        self.date = date
        self.formattedDate = date.formatted(date: .abbreviated, time: .omitted)
        self.questions = questions
        self.mood = mood

    }
}

extension Journal {
    struct Question: Codable, Identifiable {
        var id: Int
        var text: String
        var answer: String

        init(id: Int, text: String, answer: String = "") {
            self.id = id
            self.text = text
            self.answer = answer
        }
    }
 }

// struct questions {
//    enum questions {
//
//    }
// }

let journalQuestions: [Journal.Question] =
    [
        Journal.Question(
            id: 1,
            text: "I am grateful for..."),
        Journal.Question(
            id: 2,
            text: "This is how I will make today great"),
        Journal.Question(
            id: 3,
            text: "Positive affirmation"),
        Journal.Question(
            id: 4,
            text: "My good dead today"),
        Journal.Question(
            id: 5,
            text: "How I will improve"),
        Journal.Question(
            id: 6,
            text: "Great things I experienced today")
    ]

let journalQuestionsExamples: [Journal.Question] =
    [
        Journal.Question(
            id: 1,
            text: "I am grateful for...",
            answer: "That the current weather is so great."),
        Journal.Question(
            id: 2,
            text: "This is how I will make today great",
            answer: "I will be very productive today."),
        Journal.Question(
            id: 3,
            text: "Positive affirmation",
            answer: "Believe in yourself."),
        Journal.Question(
            id: 4,
            text: "My good deed today",
            answer: "To help the neighbour."),
        Journal.Question(
            id: 5,
            text: "How I will improve",
            answer: "I will go earlier to sleep."),
        Journal.Question(
            id: 6,
            text: "Great things I experienced today",
            answer: "I run my first 10k today.")
    ]

extension Journal {
    static let sampleData: [Journal] =
    [
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                questions: journalQuestionsExamples,
                mood: .awesome),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                questions: journalQuestionsExamples,
                mood: .bad),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                questions: journalQuestionsExamples,
                mood: .happy),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                questions: journalQuestionsExamples,
                mood: .awesome),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                questions: journalQuestionsExamples,
                mood: .bad),
        Journal(date: .now.addingTimeInterval(TimeInterval(86400 * -Int.random(in: 0..<9))),
                questions: journalQuestionsExamples,
                mood: .happy)
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
