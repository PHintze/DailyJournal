//
//  HomeView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftUI

struct HomeView: View {
    @Environment (\.modelContext) var modelContext
    @Environment(\.scenePhase) var scene
    @StateObject var network = Network()

    var currentDate = Date().formatted(date: .abbreviated, time: .omitted)
    let defaults = UserDefaults.standard
    let dateDefaultsKey = "LastRun"

    let gradient = LinearGradient(gradient: Gradient(colors: [.pinkGradient, .purpleGradient]),
                                  startPoint: UnitPoint(x: 0.5, y: 0.5), endPoint: .bottom)

    var body: some View {
        NavigationStack {
            ZStack {
                gradient
                    .ignoresSafeArea()
                VStack {
                    Text("Quote of the day:")
                        .font(
                            .system(size: 34, design: .rounded)
                            .weight(.heavy)
                        )
                        .foregroundStyle(.accent)

                    Group {
                        if let quote = network.quote {
                            Text("\(quote.content)")
                                .font(.title3)
                                .bold()
                                .fontDesign(.serif)
                            Text("\(quote.author)")
                                .font(.headline)
                                .fontDesign(.serif)
                        }
                    }

                    .onChange(of: scene) {
                        if scene == .active {
                            Task {
                                if currentDate != defaults.string(forKey: dateDefaultsKey) {
                                    await network.getRandomQuote()
                                    defaults.setValue(currentDate, forKey: dateDefaultsKey)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Network())
}
