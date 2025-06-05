import Foundation

/// Service responsible for loading and decoding the list of Duas from a local JSON file (`duas.txt` in Resources).
final class DuaDataService {
    /// Shared singleton instance
    static let shared = DuaDataService()
    
    /// Private initializer to enforce singleton usage
    private init() { }
    
    /// Loads all Duas from `duas.txt` (JSON) and returns an array of `Dua` models.
    /// - Returns: An array of `Dua`. Returns an empty array if the file is missing or decoding fails.
    func loadAllDuas() -> [Dua] {
        // Locate `duas.txt` in the main bundle’s Resources
        guard let url = Bundle.main.url(forResource: "duas", withExtension: "txt") else {
            print("DuaDataService Error: Could not find 'duas.txt' in Resources.")
            return []
        }
        
        do {
            // Read raw data from the file
            let data = try Data(contentsOf: url)
            // Decode JSON into [Dua]
            let decoder = JSONDecoder()
            let duas = try decoder.decode([Dua].self, from: data)
            return duas
        } catch {
            print("DuaDataService Error: Failed to load or decode 'duas.txt' — \(error)")
            return []
        }
    }
}
