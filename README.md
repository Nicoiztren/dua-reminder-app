# dua-reminder-app
iOS app in Swift for browsing a curated collection of authentic duas (Arabic, transliteration, English/Spanish) and scheduling local notifications (after Fajr, before sleep, etc.). Includes offline JSON data, detailed views, and persistent tracking via UserDefaults. Licensed MIT.
# Dua Reminder App

**Dua Reminder App** is an iOS application written in Swift that helps users browse a curated collection of authentic duas (supplications) in Arabic, transliteration, and English/Spanish translations, and schedule local notifications to remind them to recite those duas at customizable times (e.g., after Fajr, before sleep, or during moments of need). The app packages all dua data locally in a JSON file to guarantee offline availability and authenticity, while using `UserNotifications` (or `EventKit`) and `UserDefaults` for scheduling and persistent tracking of active reminders.

---

## Table of Contents

1. [Features](#features)  
2. [Screenshots](#screenshots)  
3. [Prerequisites](#prerequisites)  
4. [Installation](#installation)  
5. [Usage](#usage)  
6. [Project Structure](#project-structure)  
7. [Data Format (duas.json)](#data-format-duasjson)  
8. [Adding or Editing Duas](#adding-or-editing-duas)  
9. [Scheduling Notifications](#scheduling-notifications)  
10. [Offline Support](#offline-support)  
11. [Building & Distribution](#building--distribution)  
12. [Contributing](#contributing)  
13. [License](#license)  
14. [Acknowledgements](#acknowledgements)  

---

## Features

- **Curated Dua Library**  
  - Browse a pre-defined list of authentic duas in Arabic.  
  - View transliteration and English/Spanish translations side by side.  
  - Offline access: all dua text is stored locally in a JSON file.

- **Customizable Reminders**  
  - Schedule local notifications for any dua at a specific date/time (e.g., “After Fajr at 06:00 AM”).  
  - Optionally tie reminders to relative prayer times (e.g., 15 minutes before Maghrib).  
  - Persistent tracking: active reminders are saved in `UserDefaults` so they persist across launches.

- **Simple, Intuitive UI**  
  - **Dua List View**: A scrollable list showing titles and a brief excerpt for each dua.  
  - **Dua Detail View**: Displays the full Arabic text, transliteration, and translation.  
  - **Reminder Scheduler**: A built-in date/time picker (or prayer-time menu) to create or cancel reminders.

- **Lightweight & Offline-First**  
  - No external API calls or database requirement.  
  - Minimal dependencies—uses only Apple’s native frameworks (SwiftUI/UIKit, UserNotifications, EventKit, Foundation).

- **Open Source & MIT-Licensed**  
  - Source code hosted on GitHub under an MIT license.  
  - Issues and Pull Requests are welcome.


---

## Prerequisites

- **macOS 11.0+ (Big Sur or later)**  
- **Xcode 12.0+** (with Swift 5.3+ toolchain)  
- **iOS 14.0+ SDK** (supports deployment target iOS 14.0 or higher)  
- **Apple Developer Account** (free account is sufficient for local device testing; paid account required for App Store distribution)  

---

## Installation

1. **Clone the repository**  
   ```bash
   git clone https://github.com/Nicoiztren/dua-reminder-app.git
   cd dua-reminder-app
