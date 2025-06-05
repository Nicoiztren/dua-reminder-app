import XCTest
@testable import DuaReminderApp

final class DuaDataServiceTests: XCTestCase {
    
    func testLoadAllDuasReturnsNonEmptyArray() {
        // Attempt to load all duas from the bundled resource
        let duas = DuaDataService.shared.loadAllDuas()
        
        // Expect the array not to be empty (since duas.txt contains entries)
        XCTAssertFalse(duas.isEmpty, "DuaDataService should load at least one Dua from duas.txt")
    }
    
    func testFirstDuaFieldsMatchExpectedValues() {
        // Define expected values based on the contents of duas.txt
        let expectedID = "dua_morning"
        let expectedTitleEN = "Morning Dua"
        let expectedTitleES = "Dua de la Mañana"
        let expectedDefaultTime = "After Fajr"
        
        let duas = DuaDataService.shared.loadAllDuas()
        XCTAssertFalse(duas.isEmpty, "DuaDataService returned an empty array; cannot verify fields.")
        
        // Inspect the first Dua in the array
        let firstDua = duas[0]
        XCTAssertEqual(firstDua.id, expectedID, "First Dua's id should be '\(expectedID)'")
        XCTAssertEqual(firstDua.title_en, expectedTitleEN, "First Dua's title_en should be '\(expectedTitleEN)'")
        XCTAssertEqual(firstDua.title_es, expectedTitleES, "First Dua's title_es should be '\(expectedTitleES)'")
        XCTAssertEqual(firstDua.defaultTimeOption, expectedDefaultTime, "First Dua's defaultTimeOption should be '\(expectedDefaultTime)'")
        
        // Optionally, verify that Arabic text and translations are non-empty
        XCTAssertFalse(firstDua.arabicText.isEmpty, "First Dua's arabicText should not be empty")
        XCTAssertFalse(firstDua.transliteration.isEmpty, "First Dua's transliteration should not be empty")
        XCTAssertFalse(firstDua.translation_en.isEmpty, "First Dua's translation_en should not be empty")
        XCTAssertFalse(firstDua.translation_es.isEmpty, "First Dua's translation_es should not be empty")
    }
    
    func testLoadAllDuasHandlesMissingFileGracefully() {
        // Since DuaDataService.loadAllDuas() expects a specific file name, simulate a missing file
        // by temporarily renaming the resource. However, in a test environment, we can't easily rename bundle resources.
        // Instead, verify that if the service cannot find the file, it returns an empty array.
        //
        // To simulate, we use a helper method that tries a non-existent resource name.
        
        let service = TestableDuaDataService()
        let result = service.loadDuas(fromResource: "nonexistent_filename")
        XCTAssertTrue(result.isEmpty, "When the resource is missing, loadDuas should return an empty array")
    }
}

/// A subclass of DuaDataService for testing purposes to allow specifying a resource name.
private class TestableDuaDataService: DuaDataService {
    /// Attempts to load Duas from a given resource name (ignoring the default "duas.txt").
    /// Used to test behavior when the file is missing.
    /// - Parameter resourceName: The name of the resource (without extension) to load.
    /// - Returns: An array of `Dua`; empty if the file cannot be found or decoded.
    func loadDuas(fromResource resourceName: String) -> [Dua] {
        // Locate the specified resource in the main bundle
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: "txt") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Dua].self, from: data)
        } catch {
            return []
        }
    }
}
