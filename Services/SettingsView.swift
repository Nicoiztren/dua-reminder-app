import SwiftUI

/// Settings screen for Dua Reminder App.
/// Allows the user to change language, toggle notification reminders,
/// and perform backup/restore of reminder data.
struct SettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: - UserDefaults Keys
    private let languageKey = "selectedLanguage"         // "en" or "es"
    private let notificationsEnabledKey = "notificationsEnabled"
    
    // MARK: - State Variables
    @State private var selectedLanguage: String = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    @State private var notificationsEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationsEnabled")
    @State private var showBackupAlert: Bool = false
    @State private var showRestoreAlert: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Language Selection
                Section(header: Text("Language")) {
                    Picker("App Language", selection: $selectedLanguage) {
                        Text("English").tag("en")
                        Text("Español").tag("es")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selectedLanguage) { newLang in
                        UserDefaults.standard.setValue(newLang, forKey: languageKey)
                    }
                }
                
                // MARK: - Notifications Toggle
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Reminders")
                    }
                    .onChange(of: notificationsEnabled) { enabled in
                        UserDefaults.standard.setValue(enabled, forKey: notificationsEnabledKey)
                        if !enabled {
                            // Cancel all active reminders
                            cancelAllReminders()
                        }
                    }
                }
                
                // MARK: - Backup & Restore
                Section(header: Text("Backup & Restore")) {
                    Button(action: {
                        performBackup()
                    }) {
                        HStack {
                            Image(systemName: "tray.and.arrow.up")
                            Text("Backup Reminders to iCloud")
                        }
                    }
                    
                    Button(action: {
                        performRestore()
                    }) {
                        HStack {
                            Image(systemName: "tray.and.arrow.down")
                            Text("Restore Reminders from iCloud")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing:
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .alert(isPresented: $showBackupAlert) {
                Alert(title: Text("Backup Complete"), message: Text("Your reminders have been backed up."), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showRestoreAlert) {
                Alert(title: Text("Restore Complete"), message: Text("Your reminders have been restored."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Backup & Restore Logic
    
    private func performBackup() {
        // Fetch active reminders array from UserDefaults
        let activeReminders = UserDefaults.standard.stringArray(forKey: "activeReminders") ?? []
        // Save array to a file in iCloud Drive (Documents folder)
        if let url = FileManager.default.url(forUbiquityContainerIdentifier: nil)?
            .appendingPathComponent("Documents")
            .appendingPathComponent("dua_reminders_backup.json") {
            do {
                let data = try JSONEncoder().encode(activeReminders)
                try data.write(to: url, options: .atomic)
                showBackupAlert = true
            } catch {
                // Handle error silently or log
                print("Backup Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func performRestore() {
        // Read backup file from iCloud Drive (Documents folder)
        if let url = FileManager.default.url(forUbiquityContainerIdentifier: nil)?
            .appendingPathComponent("Documents")
            .appendingPathComponent("dua_reminders_backup.json") {
            do {
                let data = try Data(contentsOf: url)
                let restored = try JSONDecoder().decode([String].self, from: data)
                // Overwrite UserDefaults array
                UserDefaults.standard.setValue(restored, forKey: "activeReminders")
                showRestoreAlert = true
            } catch {
                // Handle error silently or log
                print("Restore Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func c
