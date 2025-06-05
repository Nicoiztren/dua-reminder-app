import Foundation

/// Model representing a single Dua entry.
/// Matches the structure of the JSON objects stored in Resources/duas.txt.
struct Dua: Codable, Identifiable {
    /// Unique identifier for this Dua (used for notifications, persistence, etc.)
    let id: String
    
    /// Title of the Dua in English.
    let title_en: String
    
    /// Title of the Dua in Spanish.
    let title_es: String
    
    /// Original Arabic text of the Dua.
    let arabicText: String
    
    /// Transliteration of the Arabic text.
    let transliteration: String
    
    /// Translation of the Dua into English.
    let translation_en: String
    
    /// Translation of the Dua into Spanish.
    let translation_es: String
    
    /// (Optional) A suggested reminder time label (e.g., “After Fajr”, “Before Sleep”).
    let defaultTimeOption: String?
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id
        case title_en
        case title_es
        case arabicText
        case transliteration
        case translation_en
        case translation_es
        case defaultTimeOption
    }
}
