//
//  NotificationManager.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }

    func scheduleNotification(for dog: Dog, on date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Heat Cycle Reminder"
        content.body = "\(dog.name)'s next heat cycle is coming soon!"
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day], from: date),
            repeats: false
        )

        let request = UNNotificationRequest(identifier: "\(dog.id)-reminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
