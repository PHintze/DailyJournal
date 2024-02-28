//
//  ContentView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @State var moodHistory: [MoodEntry]?
    @Binding var journal: Journal?
    @Binding var sortNewestFirst: SortOrder
    @Binding var searchDate: Date

    @State private var showCreateJournalView = false
    @State private var showProfileView = false
    @State var selectedTab = 1

    let gradient = LinearGradient(gradient: Gradient(colors: [.pinkGradient, .purpleGradient]),
                                  startPoint: .top, endPoint: .bottom)

    var journalBinding: Binding<Journal> {
        .init(get: { journal ?? Journal(date: .now,
                                        mood: .awesome,
                                        title: "",
                                        content: "")
        },
              set: { journal = $0 })
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }.tag(1)
                    JournalHistoryView(sortNewestFirst: $sortNewestFirst,
                                       searchDate: $searchDate,
                                       selectedJournal: journalBinding)
                        .tabItem {
                            Label("Journals", systemImage: "calendar.badge.clock.rtl")
                        }.tag(2)
                }
                .labelStyle(.iconOnly)
                .tint(.accentColor)

                Button {
                    createNewJournal()
                    showCreateJournalView = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(width: 50, height: 50)
                .background(.tint)
                .clipShape(Circle())
                .sheet(isPresented: $showCreateJournalView) {
                    CreateJournalView(journal: journalBinding,
                                      sortNewestFirst: $sortNewestFirst,
                                      searchDate: $searchDate)
                }
//                .navigationDestination(isPresented: $showCreateJournalView) {
//                    CreateJournalView(journal: $journal, sortNewestFirst: $sortNewestFirst, searchDate: $searchDate)
//                }
            }
            .ignoresSafeArea(.keyboard)
            .toolbar {
                switch selectedTab {
                case 1:
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showProfileView = true
                        } label: {
                            Label("Profile", systemImage: "person.crop.circle")
                        }
                        .navigationDestination(isPresented: $showProfileView) {
                            ProfileView()
                        }
                        .navigationTitle("Daily Quote")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                case 2:
                    ToolbarItem(placement: .topBarTrailing) {
                        JournalHistoryToolbarView(searchDate: $searchDate, sortNewestFirst: $sortNewestFirst)
                            .navigationTitle("Journals")
                    }
                default:
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showProfileView = true
                        } label: {
                            Label("Profile", systemImage: "person.crop.circle")
                        }
                        .navigationDestination(isPresented: $showProfileView) {
                            ProfileView()
                        }
                    }
                }
            }
        }
    }

    func createNewJournal() {
        let newJournal = Journal(date: .now, mood: .awesome, title: "", content: "")

        modelContext.insert(newJournal)

        journal = newJournal
    }
}

#Preview {
    ContentView(moodHistory: MoodEntry.moodHistorySampleData, journal: .constant(Journal.sampleData[0]),
                sortNewestFirst: .constant(SortOrder.forward), searchDate: .constant(.now))
}
