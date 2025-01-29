//
//  Utilities.swift
//  TheCatApi
//
//  Created by admin on 27.01.2025.
//

import Foundation

final class TestUtilities {
    static func loadJSONData(from fileName: String) -> Data {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Unable to find \(fileName).json in the test bundle.")
        }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            fatalError("Failed to load \(fileName).json: \(error)")
        }
    }
}
