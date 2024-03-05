//
//  LockedView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 29.02.2024.
//

import SwiftUI
import LocalAuthentication

struct LockedView: View {
    @Environment(\.scenePhase) var scenePhase

    @StateObject private var securityController = SecurityController()

    var body: some View {
//        ZStack {
//            Background.gradient
//                .ignoresSafeArea()
//            VStack {
                Button {
                    securityController.authenticate()
                } label: {
                    Label("Unlock", systemImage: "lock.fill")
                        .labelStyle(.iconOnly)
                        .bold()
                }
                .padding()
                .background(.indigo)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .onChange(of: scenePhase) {
                    switch scenePhase {
                    case .background, .inactive:
                        securityController.lockApp()
                    case .active:
                        securityController.showLockedViewIfEnabled()
                    default:
                        break
                    }
                }

                VStack {
                    Text("Use Face ID to unlock DailyJournal")
                        .font(.title3)
                        .bold()
                    Text("DailyJournal is locked")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
//        }
//    }
}

#Preview {
    LockedView()
}
