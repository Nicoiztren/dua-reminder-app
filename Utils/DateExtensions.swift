import XCTest
@testable import DuaReminderApp

final class DateExtensionsTests: XCTestCase {
    
    func testSettingHourMinute() {
        // Create a known date: 2025-06-05 08:30
        let calendar = Calendar.current
        var components = DateComponents(year: 2025, month: 6, day: 5, hour: 8, minute: 30)
        let originalDate = calendar.date(from: components)!
        
        // Set hour to 14 and minute to 45
        let updatedDate = originalDate.setting(hour: 14, minute: 45)
        XCTAssertNotNil(updatedDate, "setting(hour:minute:) should return a valid Date")
        
        let updatedComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: updatedDate!)
        XCTAssertEqual(updatedComponents.year, 2025)
        XCTAssertEqual(updatedComponents.month, 6)
        XCTAssertEqual(updatedComponents.day, 5)
        XCTAssertEqual(updatedComponents.hour, 14)
        XCTAssertEqual(updatedComponents.minute, 45)
    }
    
    func testIsEarlierThan() {
        let now = Date()
        let earlier = now.addingTimeInterval(-60) // 1 minute earlier
        XCTAssertTrue(earlier.isEarlier(than: now), "Earlier date should be earlier than now")
        XCTAssertFalse(now.isEarlier(than: earlier), "Now should not be earlier than earlier date")
    }
    
    func testFormattedDefaultStyles() {
        // Use fixed date: 2025-01-01 12:00
        var components = DateComponents(year: 2025, month: 1, day: 1, hour: 12, minute: 0)
        let date = Calendar.current.date(from: components)!
        let formatted = date.formatted()
        // Default medium date style and short time style produce non-empty string
        XCTAssertFalse(formatted.isEmpty, "formatted() should return a non-empty string")
    }
    
    func testMinutesFromDifference() {
        // Create two dates 90 minutes apart
        let base = Date()
        let later = base.addingTimeInterval(90 * 60) // 90 minutes ahead
        
        if let diff = later.minutes(from: base) {
            XCTAssertEqual(diff, 90, "Difference in minutes should be 90")
        } else {
            XCTFail("minutes(from:) returned nil unexpectedly")
        }
        
        // Reverse order should yield negative
        if let reverseDiff = base.minutes(from: later) {
            XCTAssertEqual(reverseDiff, -90, "Difference in minutes should be -90")
        } else {
            XCTFail("minutes(from:) returned nil for reverse order")
        }
    }
    
    func testAddingOffset() {
        // Base date: 2025-06-05 00:00
        let calendar = Calendar.current
        var components = DateComponents(year: 2025, month: 6, day: 5, hour: 0, minute: 0)
        let baseDate = calendar.date(from: components)!
        
        // Add offset of 2 days, 3 hours, 30 minutes
        let offsetDict: [Calendar.Component: Int] = [
            .day: 2,
            .hour: 3,
            .minute: 30
        ]
        let newDate = baseDate.adding(offset: offsetDict)
        XCTAssertNotNil(newDate, "adding(offset:) should return a valid Date")
        
        let newComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: newDate!)
        XCTAssertEqual(newComponents.year, 2025)
        XCTAssertEqual(newComponents.month, 6)
        XCTAssertEqual(newComponents.day, 7)      // 5 + 2 days
        XCTAssertEqual(newComponents.hour, 3)
        XCTAssertEqual(newComponents.minute, 30)
    }
}
