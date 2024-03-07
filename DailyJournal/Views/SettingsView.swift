//
//  SettingsView.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 08.02.2024.
//

import SwiftUI

struct SettingsView: View {
    // Save the state of the toggle on/off for daily reminder
    @AppStorage("isScheduled") var isScheduled = false
    // Save the notification time set by user for daily reminder
    @AppStorage("notificationTimeString") var notificationTimeString = "08:00"

    @Environment(\.colorScheme) var colorScheme

    @State private var showDatePicker = false

    @StateObject private var securityController = SecurityController()

    var body: some View {
        VStack {
            List {
                Section(header: Text("New Entry"),
                        footer: Text("Get notified to write every day at \(notificationTimeString).")) {
                    // The toggle if the user want to use daily reminder feature
                    Toggle("Daily Reminder", isOn: $isScheduled)
                        .onChange(of: isScheduled) {
                            handleIsScheduledChange(isScheduled: isScheduled)
                        }
                        .accessibilityIdentifier("ReminderToggle")

                    if isScheduled {
                        HStack {
                            Text("Time")

                            Spacer()

                            Button {
                                showDatePicker.toggle()
                            } label: {
                                Text(notificationTimeString)
                            }
                            .accessibilityIdentifier("NotificationTime")
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.roundedRectangle(radius: 10))
                            .popover(isPresented: $showDatePicker, attachmentAnchor: .point(.leading)) {
                                DatePicker("Notification Time", selection: Binding(
                                    get: {
                                        // Get the notification time schedule set by user
                                        DateHelper.dateFormatter.date(from: notificationTimeString) ?? Date()
                                    },
                                    set: {
                                        // On value set, change the notification time
                                        notificationTimeString = DateHelper.dateFormatter.string(from: $0)
                                        handleNotificationTimeChange()
                                    }
                                    // Only use hour and minute components, since this is a daily reminder
                                ), displayedComponents: .hourAndMinute)
                                // Use wheel date picker style, recommended by Apple
                                .datePickerStyle(WheelDatePickerStyle())
                                .frame(width: 250, height: 200)
                                .presentationCompactAdaptation(.popover)
                                .accessibilityIdentifier("ReminderDatePicker")
                            }

                        }
                    }
                }

                Section(footer: Text("Lock your journals using the device passcode or Face ID.")) {
                    Toggle("Lock Journal", isOn: $securityController.isAppLockEnabled)
                        .onChange(of: securityController.isAppLockEnabled) {
                            securityController.appLockStateChange(securityController.isAppLockEnabled)
                            print(securityController.isAppLockEnabled)
                        }
                        .accessibilityIdentifier("AuthToggle")
                }
            }
            .tint(.indigo)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(hideBackground())
        }
        .background(Background.gradient)
    }

}

private extension SettingsView {
    private func hideBackground() -> Visibility {
        if colorScheme == .dark {
            return .hidden
        } else {
            return .automatic
        }
    }
}

private extension SettingsView {
    // Handle if the user turned on/off the daily reminder feature
    private func handleIsScheduledChange(isScheduled: Bool) {
        if isScheduled {
            NotificationManager.requestNotificationAuthorization()
            NotificationManager.scheduleNotification(notificationTimeString: notificationTimeString)
        } else {
            NotificationManager.cancelNotification()
        }
    }

    // Handle if the notification time changed from DatePicker
    private func handleNotificationTimeChange() {
        NotificationManager.cancelNotification()
        NotificationManager.requestNotificationAuthorization()
        NotificationManager.scheduleNotification(notificationTimeString: notificationTimeString)
    }
}

#Preview {
    SettingsView()
}
