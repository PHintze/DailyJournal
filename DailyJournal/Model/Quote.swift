//
//  Quote.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import Foundation

struct Quote: Decodable {
    var id = UUID()
    var content: String
    var author: String

    enum CodingKeys: String, CodingKey {
        case content = "q"
        case author = "a"
    }
}
