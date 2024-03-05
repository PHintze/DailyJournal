//
//  Network.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftUI

enum RandomQuoteAPI {

    static func getRandomQuote() async -> Quote? {
        do {
            guard let url = URL(string: "https://zenquotes.io/api/random") else { fatalError("Missing URL") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([Quote].self, from: data)

            // Prints the first quote to the console
            print(decodedData[0])
            print(Date().formatted(date: .omitted, time: .shortened))
            return decodedData[0]
        } catch {
            print("Error fetching data from API: \(error)")
            return nil
        }
    }
}
