//
//  HomeView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var quote: Quote

    var body: some View {
        NavigationStack {
            ZStack {
                Background.gradient
                    .ignoresSafeArea()
                VStack {
                    Text("Quote of the day:")
                        .font(
                            .system(size: 34, design: .rounded)
                            .weight(.heavy)
                        )
                        .foregroundStyle(.accent)

                    Group {
                        Text("\(quote.content)")
                            .font(.title3)
                            .bold()
                            .fontDesign(.serif)
                        Text("\(quote.author)")
                            .font(.headline)
                            .fontDesign(.serif)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
