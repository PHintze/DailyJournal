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

    var currentDate = Date().formatted(date: .long, time: .omitted)
    @State var storedDate = String()
    let defaults = UserDefaults.standard

    @State var quote: Quote?
    @Binding var journal: Journal?
    @State private var showProfileView = false

    var journalBinding: Binding<Journal> {
        .init(get: { journal ?? Journal(date: .now, questions: journalQuestions, mood: nil)},
              set: { journal = $0 })
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text("Quote of the day:")
                    .font(
                        .system(size: 34, design: .rounded)
                        .weight(.heavy)
                    )

                Text(currentDate)
                Text("\(storedDate)")
                Text(defaults.object(forKey: "LastRun") as? String ?? String())
                Button("Change Date") {
                    storedDate = Date().addingTimeInterval(TimeInterval(86400*7)).formatted(date: .long, time: .omitted)
                }
                Group {
                    if let quote {
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
                            quote = network.quote
                        print("Active")
                    }
                    print(quote?.author)
                    print(quote?.content)
                }
            }
            .padding()
//            .onAppear {
//                if currentDate != storedDate {
//                    quote = network.quote
//                    defaults.set(Date().formatted(date: .long, time: .omitted), forKey: "LastRun")
//                    storedDate = defaults.object(forKey: "LastRun") as? String ?? String()
//                }
//            }

            Spacer()

            NavigationLink("Start Journaling", destination: CreateJournalView(journal: journalBinding))
                .background(.plantation)
                .buttonStyle(.bordered)
                .controlSize(.large)
                .tint(.accentColor)
                .font(.title3)

            Spacer()
                .toolbar {
                        Button {
                            showProfileView = true
                        } label: {
                            Label("Profile", systemImage: "person.crop.circle")
                        }
                }
        }

    }
}

#Preview {
    HomeView(quote: Quote(id: UUID(), content: "Content", author: "Author"), journal: .constant(Journal.sampleData[0]))
        .environmentObject(Network())
}
