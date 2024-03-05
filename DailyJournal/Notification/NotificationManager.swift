//
//  NotificationManager.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 28.02.2024.
//

import Foundation
import UserNotifications

struct NotificationManager {
    // Request user authorization for notifications
    static func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                print("Notification authorization granted.")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    // Schedule daily notification at user-selected time
    static func scheduleNotification(notificationTimeString: String) {
        // Convert the time in string to date
        guard let date = DateHelper.dateFormatter.date(from: notificationTimeString) else {
            return
        }

        // Instantiate a variable for UNMutableNotificationContent
        let content = UNMutableNotificationContent()
        // The notification title
        content.title = "Write in your journal"
        // The notification body
        content.body = "Take a few minutes to write down your thoughts and feelings."
        content.sound = .default

        // Set the notification to repeat daily for the specified hour and minute
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // We need the identifier "journalReminder" so that we can cancel it later if needed
        // The identifier name could be anything, up to you
        let request = UNNotificationRequest(identifier: "journalReminder", content: content, trigger: trigger)

        // Schedule the notification
        UNUserNotificationCenter.current().add(request)
    }

    // Cancel any scheduled notifications
    static func cancelNotification() {
        // Cancel the notification with identifier "journalReminder"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["journalReminder"])
    }
}
