import XCTest
import SwiftUI
@testable import DuaReminderApp

final class DuaListViewTests: XCTestCase {
    
    /// Test that DuaListView can be instantiated and its view hierarchy loads without crashing.
    func testDuaListViewInstantiation() {
        // Instantiate the SwiftUI view
        let view = DuaListView()
        // Embed in a UIHostingController to load the view
        let hostingController = UIHostingController(rootView: view)
        
        // Force the view to load
        XCTAssertNotNil(hostingController.view, "DuaListView's view should load successfully")
    }
    
    /// Test that the underlying data service provides at least one Dua, so the list is non-empty.
    func testDuaListViewDisplaysData() {
        // Ensure the data service returns some Duas
        let duas = DuaDataService.shared.loadAllDuas()
        XCTAssertFalse(duas.isEmpty, "DuaDataService should load at least one Dua")
        
        // Instantiate DuaListView and trigger onAppear by forcing the view to appear
        let expectation = XCTestExpectation(description: "DuaListView onAppear loads data")
        
        let view = DuaListView()
        let hostingController = UIHostingController(rootView: view.onAppear {
            // After onAppear, the internal @State array should be populated
            expectation.fulfill()
        })
        
        // Load the view hierarchy
        XCTAssertNotNil(hostingController.view, "DuaListView's view should load")
        
        wait(for: [expectation], timeout: 2.0)
    }
}
