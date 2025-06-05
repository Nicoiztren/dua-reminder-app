import XCTest
import UserNotifications
@testable import DuaReminderApp

final class NotificationServiceTests: XCTestCase {
    
    var notificationService: NotificationService!
    let testDua = Dua(
        id: "test_dua",
        title_en: "Test Dua",
        title_es: "Dua de Prueba",
        arabicText: "تِجْرِبَةٌ",
        transliteration: "Tajriba",
        translation_en: "Test",
        translation_es: "Prueba",
        defaultTimeOption: nil
    )
    
    override func setUp() {
        super.setUp()
        notificationService = NotificationService.shared
        
        // Remove any existing pending notifications before each test
        let center = UNUserNotificationCenter.current()
        let expectation = XCTestExpectation(description: "Clear pending notifications")
        center.getPendingNotificationRequests { requests in
            let ids = requests.map { $0.identifier }
            center.removePendingNotificationRequests(withIdentifiers: ids)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    override func tearDown() {
        super.tearDown()
        // Clean up: cancel any test notifications
        notificationService.cancelNotification(for: testDua)
    }
    
    func testRequestPermissionCompletes() {
        let expectation = XCTestExpectation(description: "Permission request should complete")
        
        notificationService.requestPermission { granted in
            // We only assert that the callback is invoked; actual granted value depends on environment
            XCTAssertNotNil(granted, "Permission callback should return a boolean")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testScheduleNotificationThenFetchesPendingID() {
        // Schedule a notification 1 minute from now
        let fireDate = Date().addingTimeInterval(60)
        notificationService.scheduleNotification(for: testDua, at: fireDate)
        
        let expectation = XCTestExpectation(description: "Pending notification request must include test_dua")
        
        // Allow a brief delay for the scheduling to register
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                let ids = requests.map { $0.identifier }
                XCTAssertTrue(ids.contains(self.testDua.id), "Pending notifications should include the scheduled test_dua ID")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCancelNotificationRemovesPendingID() {
        // Schedule first
        let fireDate = Date().addingTimeInterval(60)
        notificationService.scheduleNotification(for: testDua, at: fireDate)
        
        let scheduleExpectation = XCTestExpectation(description: "Notification scheduled")
        // Wait briefly, then cancel and verify
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Cancel the scheduled notification
            self.notificationService.cancelNotification(for: self.testDua)
            scheduleExpectation.fulfill()
        }
        wait(for: [scheduleExpectation], timeout: 5.0)
        
        let cancelExpectation = XCTestExpectation(description: "Pending notification request should be removed")
        // Allow a brief delay for cancellation to apply
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                let ids = requests.map { $0.identifier }
                XCTAssertFalse(ids.contains(self.testDua.id), "Pending notifications should not include the test_dua ID after cancellation")
                cancelExpectation.fulfill()
            }
        }
        
        wait(for: [cancelExpectation], timeout: 5.0)
    }
}
