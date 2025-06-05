import XCTest

@testable import DuaReminderApp

final class DuaTests: XCTestCase {
    
    // Sample JSON string representing an array with one Dua object
    private let sampleJSON = """
    [
      {
        "id": "dua_morning",
        "title_en": "Morning Dua",
        "title_es": "Dua de la Mañana",
        "arabicText": "اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ",
        "transliteration": "Allahumma bika asbahna wa bika amsayna wa bika nahya wa bika namutu wa ilayka al-nushoor",
        "translation_en": "O Allah, by Your leave we have reached the morning and by Your leave we have reached the evening, by Your leave we live and by Your leave we die, and unto You is our resurrection.",
        "translation_es": "¡Oh Allah! Con Tu permiso hemos llegado a la mañana y con Tu permiso hemos llegado a la noche, con Tu permiso vivimos y con Tu permiso morimos, y a Ti regresaremos.",
        "defaultTimeOption": "After Fajr"
      }
    ]
    """
    
    func testDuaDecodingSucceeds() throws {
        let data = Data(sampleJSON.utf8)
        let decoder = JSONDecoder()
        
        let duas = try decoder.decode([Dua].self, from: data)
        
        XCTAssertEqual(duas.count, 1, "Decoded array should contain exactly one Dua")
        
        let dua = duas.first!
        XCTAssertEqual(dua.id, "dua_morning")
        XCTAssertEqual(dua.title_en, "Morning Dua")
        XCTAssertEqual(dua.title_es, "Dua de la Mañana")
        XCTAssertEqual(dua.arabicText, "اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ")
        XCTAssertEqual(dua.transliteration, "Allahumma bika asbahna wa bika amsayna wa bika nahya wa bika namutu wa ilayka al-nushoor")
        XCTAssertEqual(dua.translation_en, "O Allah, by Your leave we have reached the morning and by Your leave we have reached the evening, by Your leave we live and by Your leave we die, and unto You is our resurrection.")
        XCTAssertEqual(dua.translation_es, "¡Oh Allah! Con Tu permiso hemos llegado a la mañana y con Tu permiso hemos llegado a la noche, con Tu permiso vivimos y con Tu permiso morimos, y a Ti regresaremos.")
        XCTAssertEqual(dua.defaultTimeOption, "After Fajr")
    }
    
    func testDuaDecodingFailsWithInvalidJSON() {
        let invalidJSON = """
        [
          {
            "id": "dua_missing_fields"
            // Missing other required fields
          }
        ]
        """
        let data = Data(invalidJSON.utf8)
        let decoder = JSONDecoder()
        
        XCTAssertThrowsError(try decoder.decode([Dua].self, from: data), "Decoding should fail when required fields are missing") { error in
            // Optionally, verify the decoding error type
            if case DecodingError.keyNotFound(let key, _) = error {
                XCTAssertEqual(key.stringValue, "title_en")
            } else {
                XCTFail("Expected keyNotFound error for 'title_en'; got \(error)")
            }
        }
    }
}
