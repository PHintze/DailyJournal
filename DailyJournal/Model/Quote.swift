//
//  Quote.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import Foundation

class Quote: Decodable, ObservableObject {
    static let `default` = Quote(
        content: UserDefaults.standard.string(forKey: "LastQuoteContent") ?? "Content",
        author: UserDefaults.standard.string(forKey: "LastQuoteAuthor") ?? "Author")
    var id = UUID()
    var content: String
    var author: String

    enum CodingKeys: String, CodingKey {
        case content = "q"
        case author = "a"
    }

    init(content: String, author: String) {
        self.content = content
        self.author = author
    }
}
