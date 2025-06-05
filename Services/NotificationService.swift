import Foundation
import UserNotifications

/// Service responsible for requesting notification permissions,
/// scheduling, and canceling local notifications for Dua reminders.
final class NotificationService {
    /// Shared singleton instance
    static let shared = NotificationService()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    /// Private initializer to enforce singleton usage
    private init() { }
    
    // MARK: - Permission Handling
    
    /// Requests authorization for sending local notifications (alert + sound).
    /// - Parameter completion: Closure that returns true if permission was granted, false otherwise.
    func requestPermission(completion: @escaping (Bool) -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("NotificationService Error: Permission request failed — \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    // MARK: - Scheduling Notifications
    
    /// Schedules a one-time local notification for the specified Dua at the given date.
    /// - Parameters:
    ///   - dua: The `Dua` model representing the reminder’s content and identifier.
    ///   - date: The `Date` at which the notification should fire.
    func scheduleNotification(for dua: Dua, at date: Date) {
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Dua Reminder"
        content.body = dua.title_en
        content.sound = .default
        
        // Convert `Date` to `DateComponents` for the trigger
        let triggerDateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
        
        // Create request using Dua’s unique ID
        let request = UNNotificationRequest(
            identifier: dua.id,
            content: content,
            trigger: trigger
        )
        
        // Add request to Notification Center
        notificationCenter.add(request) { error in
            if let error = error {
                print("NotificationService Error: Failed to schedule notification — \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Canceling Notifications
    
    /// Cancels any pending notification request associated with the specified Dua.
    /// - Parameter dua: The `Dua` model whose pending notification should be canceled.
    func cancelNotification(for dua: Dua) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [dua.id])
    }
    
    /// Cancels all pending notifications (useful if the user disables all reminders).
    func cancelAllNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    // MARK: - Retrieving Pending Notifications
    
    /// Fetches the identifiers of all pending notification requests.
    /// - Parameter completion: Closure that returns an array of identifier strings.
    func fetchPendingNotificationIDs(completion: @escaping ([String]) -> Void) {
        notificationCenter.getPendingNotificationRequests { requests in
            let ids = requests.map { $0.identifier }
            DispatchQueue.main.async {
                completion(ids)
            }
        }
    }
}

