//
//  DarkmodeBackground.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 05.03.2024.
//

import SwiftUI

struct Background {
    static let gradient = LinearGradient(gradient: Gradient(colors: [.darkPurpleGradient, .purpleGradient]),
                                             startPoint: UnitPoint(x: 0.5, y: 0.5), endPoint: .bottom)
}
