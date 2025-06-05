```markdown
# Contributing to Dua Reminder App

Thank you for considering contributions to the **Dua Reminder App**. Even though this project is intended for personal use and will not be published publicly, maintaining a clear process helps keep code quality high and ensures future maintainability. This document outlines guidelines for submitting changes, reporting issues, and following coding conventions.

---

## Table of Contents

1. [Reporting Issues](#reporting-issues)  
2. [Suggesting New Features](#suggesting-new-features)  
3. [Development Setup](#development-setup)  
4. [Branching and Workflow](#branching-and-workflow)  
5. [Code Style and Formatting](#code-style-and-formatting)  
6. [Writing and Running Tests](#writing-and-running-tests)  
7. [Commit Message Guidelines](#commit-message-guidelines)  
8. [Pull Request Checklist](#pull-request-checklist)  
9. [Code Review Process](#code-review-process)  
10. [Documentation Updates](#documentation-updates)  
11. [License and Copyright](#license-and-copyright)  

---

## Reporting Issues

Even if this is a private project, it’s helpful to track known bugs or unexpected behavior. Use the following template when noting an issue:

- **Title**: Short, descriptive summary of the bug (e.g., “Scheduling reminders fails after app relaunch”).
- **Description**: Detailed explanation of what happened, including:
  - Steps to reproduce
  - Expected behavior
  - Actual behavior
  - Any error messages or console logs
- **Environment**:
  - Swift Playgrounds version (iPad OS version)
  - iOS Simulator or device model
  - Date/time settings, language/region settings (if relevant)

Record these in a personal issue tracker (a local file or Notes app), or add them under `Tests/Issues.md` if you prefer maintaining a central log.

---

## Suggesting New Features

If you have ideas for improvements or new functionality (e.g., “Add support for recurring daily reminders” or “Integrate iCloud backup for reminders”), follow these steps:

1. **Create a Feature Request Entry**  
   - In a local file (e.g., `Tests/FeatureRequests.md`), create a new heading with:
     - **Title**: One-line summary  
     - **Description**: Rationale, use cases, and minimal mockups or diagrams if helpful  
     - **Priority**: Low / Medium / High  
     - **Dependencies**: Any other features that must exist first  

2. **Discuss Feasibility**  
   - Consider impact on existing structure (e.g., Services, Views).  
   - Estimate effort and identify any third-party packages needed (add to `Packages.txt` if required).

3. **Assign Yourself**  
   - Once ready, begin working on a new branch (see [Branching and Workflow](#branching-and-workflow)).

---

## Development Setup

1. **Copy or Clone the Project**  
   - Copy the `DuaReminderApp` folder into your Swift Playgrounds app on iPad.

2. **Open Main Entry**  
   - Open `ContentView.swift` (or `DuaListView.swift`) in Swift Playgrounds.

3. **Install Swift Packages (if any)**  
   - Open `Packages.txt` and identify any URLs you need.  
   - In Swift Playgrounds, tap “+” → “Add Swift Package” → paste the URL.  
   - Wait for the package to resolve before importing it in code (e.g., `import SwiftyJSON`).

4. **Ensure Dependencies Resolve**  
   - If using a JSON utility or prayer-time package, check that Xcode/Playgrounds shows no import errors.

---

## Branching and Workflow

For any change—bug fix, feature, or refactoring—create a dedicated branch to isolate your work. Use the following naming convention:

- `bugfix/<short-descriptive-name>`  
- `feature/<short-descriptive-name>`  
- `refactor/<module-or-function-name>`

Example:  
```

feature/recurring-reminders
bugfix/json-decoding-error
refactor/NotificationService

````

After finalizing changes, merge back into `main` (or your working main branch) following the [Pull Request Checklist](#pull-request-checklist).

---

## Code Style and Formatting

Maintain a consistent Swift style throughout the project. Suggestions:

- **Indentation**: 4 spaces per level (no tabs).  
- **Braces**: Opening brace on the same line as declaration (K&R style).  
  ```swift
  // Correct:
  func loadAllDuas() -> [Dua] {
      // ...
  }

  // Incorrect:
  func loadAllDuas() -> [Dua]
  {
      // ...
  }
````

* **Naming**:

  * Types (struct, class, enum, protocol): UpperCamelCase (e.g., `DuaDataService`).
  * Variables and functions: lowerCamelCase (e.g., `loadAllDuas()`, `scheduleNotification`).
  * Constants: lowerCamelCase (unless truly global, avoid ALL\_CAPS).

* **Line Length**: Aim for ≤ 100 characters per line. Break long chained calls or strings accordingly.

* **Commenting**:

  * Public methods and properties should have a brief doc comment (`///`).
  * Inline comments only to clarify non-obvious logic (avoid obvious comments).

* **SwiftLint** (optional):

  * If you integrate SwiftLint in CI, follow its default rules or configure `.swiftlint.yml` to match these guidelines.

---

## Writing and Running Tests

Even if the project is private, tests help validate logic:

1. **Unit Tests for Models**

   * Verify JSON decoding for `Dua.swift`.
   * Example: Create sample JSON in code, decode to `[Dua]`, assert the fields match expected values.

2. **Unit Tests for Services**

   * `DuaDataServiceTests.swift`: Test with both valid and invalid JSON data to ensure proper error handling.
   * `NotificationServiceTests.swift`: Simulate permission granting and test scheduling/canceling logic (may require stubbing `UNUserNotificationCenter`).

3. **UI Tests** (optional)

   * If using SwiftUI previews, use snapshot testing or assert that views load without crashes.
   * For example, instantiate `DuaListView()` in a test and verify that a known sample dua appears.

4. **Running Tests**

   * In Swift Playgrounds: there is no built-in test runner, but you can manually call test functions in a dedicated “Tests” playground page.
   * If you eventually move to Xcode, run tests via `Cmd + U` or the Test navigator.

---

## Commit Message Guidelines

Clear, concise commit messages make it easy to track changes. Follow this structure:

```
<type>: <subject>

<body>
```

* **type**: one of `feat`, `fix`, `docs`, `style`, `refactor`, `test`, or `chore`.
* **subject**: short summary (imperative, present tense, ≤ 50 characters).
* **body** (optional): more context or explanation (wrap at 72 characters).

Examples:

* `feat: add recurring daily reminders option`
* `fix: correct JSON decoding error when trailing comma present`
* `docs: update README with Swift Package instructions`
* `style: reindent code to 4 spaces, remove extra whitespace`
* `refactor: split NotificationService into smaller helpers`
* `test: add unit tests for DuaDataService JSON loading`
* `chore: update Packages.txt, remove unused URLs`

---

## Pull Request Checklist

Before merging a branch into `main`, ensure:

* [ ] Branch name follows the naming convention.
* [ ] All new code compiles without errors in Swift Playgrounds.
* [ ] Adherence to code style guidelines (indentation, naming, comments).
* [ ] All unit tests (if any) pass successfully.
* [ ] No leftover `print` statements or debug code.
* [ ] `README.md`, `CHANGELOG.md`, or other documentation is updated if behavior changes.
* [ ] If adding external packages, verify `Packages.txt` includes the correct URL and version.
* [ ] No sensitive information (API keys, personal data) is committed.

Once this list is complete, merge the branch into `main` and delete the feature/bugfix branch.

---

## Code Review Process

1. **Self-Review**: Before creating a pull request, review your own changes for errors, style consistency, and missing documentation.
2. **Peer Review** (if applicable): If someone else is available, request they scan for logic issues, potential edge cases, or performance concerns.
3. **Approve & Merge**: After all feedback is addressed, merge to `main`. For private use, you may skip formal reviews, but still perform a brief self-check.

---

## Documentation Updates

Whenever you modify functionality, update related documentation:

* **README.md**: Reflect any changes to setup, features, or file structure.
* **CHANGELOG.md**: Add a new version entry with a summary of changes (e.g., “v1.1.0 — Added iCloud backup in BackupService”).
* **Localizable.strings**: If you add any new user-facing text, include entries for translations.
* **LaunchScreen.txt**: If the launch screen design changes, update instructions or assets accordingly.

---

## License and Copyright

By contributing to this project, you agree that your contributions will be under the same MIT License specified in `LICENSE.txt`. Ensure that any third-party code you add is compatible with MIT or another permissive license.

```
```
