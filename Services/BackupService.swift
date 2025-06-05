import Foundation

/// Service responsible for backing up and restoring active Dua reminder IDs to/from iCloud Drive.
final class BackupService {
    /// Shared singleton instance
    static let shared = BackupService()
    
    /// Filename used for backup in iCloud Drive
    private let backupFilename = "dua_reminders_backup.json"
    
    /// Key for active reminders stored in UserDefaults
    private let activeRemindersKey = "activeReminders"
    
    private init() { }
    
    // MARK: - Public Methods
    
    /// Backs up the current array of active reminder IDs to iCloud Drive (Documents directory).
    /// - Returns: True if backup succeeded, false otherwise.
    func backupActiveReminders() -> Bool {
        // Retrieve active reminders from UserDefaults
        let activeReminders = UserDefaults.standard.stringArray(forKey: activeRemindersKey) ?? []
        
        // Encode the array into JSON data
        do {
            let data = try JSONEncoder().encode(activeReminders)
            guard let url = iCloudBackupURL() else {
                print("BackupService Error: iCloud container URL not available.")
                return false
            }
            
            // Ensure the Documents directory exists
            let documentsURL = url.appendingPathComponent("Documents", isDirectory: true)
            try FileManager.default.createDirectory(at: documentsURL, withIntermediateDirectories: true)
            
            // Write the JSON data to the backup file
            let fileURL = documentsURL.appendingPathComponent(backupFilename)
            try data.write(to: fileURL, options: .atomic)
            return true
        } catch {
            print("BackupService Error: Failed to encode or write backup data — \(error)")
            return false
        }
    }
    
    /// Restores the array of active reminder IDs from iCloud Drive backup.
    /// - Returns: The restored array of reminder IDs, or nil if restoration failed.
    func restoreActiveReminders() -> [String]? {
        do {
            guard let url = iCloudBackupURL() else {
                print("BackupService Error: iCloud container URL not available.")
                return nil
            }
            
            let fileURL = url
                .appendingPathComponent("Documents", isDirectory: true)
                .appendingPathComponent(backupFilename)
            
            // Read data from backup file
            let data = try Data(contentsOf: fileURL)
            let restored = try JSONDecoder().decode([String].self, from: data)
            
            // Overwrite UserDefaults
            UserDefaults.standard.setValue(restored, forKey: activeRemindersKey)
            return restored
        } catch {
            print("BackupService Error: Failed to read or decode backup data — \(error)")
            return nil
        }
    }
    
    // MARK: - Helpers
    
    /// Returns the URL to the app’s iCloud container, or nil if unavailable.
    private func iCloudBackupURL() -> URL? {
        FileManager.default.url(
            forUbiquityContainerIdentifier: nil
        )
    }
}
