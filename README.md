```markdown
# Dua Reminder App

This is an iOS application written in Swift (SwiftUI) to **schedule reminders for authentic duas** (supplications). It is designed to run locally in Swift Playgrounds or the Swift app on iPad Pro. **It is not intended for public distribution**—this is a personal project that will not be published on the App Store or shared in public repositories.

---

## Description

- Browse a collection of duas in Arabic, transliteration, and English/Spanish translations.
- **Schedule local notifications** for each dua at any date/time you choose (e.g., after Fajr, before sleeping).
- All dua data is packaged locally in a text file (JSON) to ensure **offline availability**.
- Uses `UserNotifications` to manage reminders and `UserDefaults` to persist the state of active notifications.

---

## How to Run the Project

1. **Copy the Entire Folder**  
   Copy the `DuaReminderApp` folder to the Files app on your iPad (iCloud Drive, Dropbox, etc.).

2. **Open in Swift Playgrounds**  
   - Launch **Swift Playgrounds** on the iPad.  
   - Tap the “+” button and choose “Import” → “From Files”.  
   - Navigate to the `DuaReminderApp` folder and select it.  
   - You will see the `.swift` and `.txt` files listed in the Playgrounds browser.

3. **Select the Entry View**  
   - Tap `ContentView.swift` (or `DuaListView.swift`) to open it.  
   - Tap the ▶️ (“Run”) button to compile and view the interface in the built-in simulator.

4. **Test the App**  
   - Browse the list of duas.  
   - Tap on a dua to view its details (Arabic text, transliteration, translation).  
   - Tap “Schedule Reminder” to choose a date/time and save a reminder.  
   - Grant notification permission when prompted.

---

## Project Folder and File Structure

```

DuaReminderApp/
├── LICENSE.txt
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── Packages.txt
├── .gitignore
│
├── Resources/
│   ├── duas.txt
│   ├── AppIcon/
│   │   └── \[PNG files for app icons in all required sizes]
│   ├── LaunchScreen.txt
│   └── Localizable.strings
│
├── Models/
│   └── Dua.swift
│
├── Services/
│   ├── DuaDataService.swift
│   ├── NotificationService.swift
│   └── BackupService.swift
│
├── Views/
│   ├── ContentView\.swift
│   ├── DuaListView\.swift
│   ├── DuaDetailView\.swift
│   ├── ScheduleReminderView\.swift
│   └── SettingsView\.swift
│
├── Utils/
│   └── DateExtensions.swift
│
├── Tests/
│   ├── Models/
│   │   └── DuaTests.swift
│   ├── Services/
│   │   ├── DuaDataServiceTests.swift
│   │   └── NotificationServiceTests.swift
│   └── Views/
│       └── DuaListViewTests.swift
│
└── CI/
└── workflow\.yml

```

- **LICENSE.txt**  
  Contains the MIT license for personal use.

- **README.md**  
  This file explaining how to run the app, folder structure, and usage.

- **CHANGELOG.md**  
  A log of changes and versions for the project (optional but recommended).

- **CONTRIBUTING.md**  
  Internal guidelines on code style, testing, and organization (useful even if not public).

- **Packages.txt**  
  A list of URLs for any Swift Packages you might add (if needed).

- **.gitignore**  
  Patterns for files to ignore if you version locally.

---

- **Resources/**  
  - **duas.txt**: JSON file containing the list of duas.  
  - **AppIcon/**: Folder with all required PNG files for different app icon sizes and a `Contents.json` descriptor.  
  - **LaunchScreen.txt**: Instructions for recreating the launch screen in SwiftUI (no storyboards used).  
  - **Localizable.strings**: Translated strings if you want multi-language support.

---

- **Models/**  
  - **Dua.swift**: Defines the `struct Dua: Codable, Identifiable` to map the JSON data.

---

- **Services/**  
  - **DuaDataService.swift**: Logic to load and decode `duas.txt` into an array of `Dua`.  
  - **NotificationService.swift**: Requests permissions and creates/cancels local notifications.  
  - **BackupService.swift**: (Optional) Allows exporting/importing user reminder data to iCloud Drive or local files.

---

- **Views/**  
  - **ContentView.swift**: SwiftUI entry point that displays `DuaListView`.  
  - **DuaListView.swift**: Main screen showing a list of all duas.  
  - **DuaDetailView.swift**: Shows details of each dua with Arabic text, transliteration, translation, and a button to schedule a reminder.  
  - **ScheduleReminderView.swift**: Modal view to pick date/time and confirm a reminder.  
  - **SettingsView.swift**: (Optional) User settings for language, permissions, and backup.

---

- **Utils/**  
  - **DateExtensions.swift**: `Date` extensions for date/time utilities (e.g., setting hour/minute, formatting).

---

- **Tests/**  
  Contains unit tests to validate models, services, and views (useful even if it’s a local project):
  - **Models/DuaTests.swift**: Tests ensuring `Dua` decodes correctly from JSON.  
  - **Services/DuaDataServiceTests.swift**: Tests verifying that `DuaDataService` properly loads and parses `duas.txt`.  
  - **Services/NotificationServiceTests.swift**: Tests simulating permission requests and scheduling/canceling notifications.  
  - **Views/DuaListViewTests.swift**: UI tests for the `DuaListView` in SwiftUI (e.g., snapshot or behavior checks).

---

- **CI/workflow.yml**  
  Configuration for Continuous Integration (e.g., GitHub Actions) to run:
  1. Static linting (SwiftLint).  
  2. Unit tests (`xcodebuild test`).  
  3. Project build (`xcodebuild build`).  
  4. (Optional) Accessibility and code quality checks.

---

## Customization and Personal Use

- Adjust colors, fonts, and styles in SwiftUI as you like.  
- Modify `duas.txt` to add, edit, or remove duas.  
- If you don’t need tests or CI, you can ignore those folders—they are provided as references.  
- Use `BackupService.swift` to back up your reminders to iCloud Drive if you want to preserve your settings.

---

## Final Notes

- **No App Store or public distribution required**: This README assumes the project remains private.  
- **All code stays on your iPad**: No remote repository is needed.  
- **You can add Swift Packages** by copying URLs from `Packages.txt` and pasting them into Swift Playgrounds (“Add Swift Package”).  
- **The proposed structure** gives you a fully organized project “from beginning to end,” with clear separation of responsibilities and room to expand features in the future.

Ready to use and enjoy!  
```
