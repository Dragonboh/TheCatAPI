//
//  Utilities.swift
//  TheCatApi
//
//  Created by admin on 27.01.2025.
//



import Foundation

enum Utilities {
    
    static func decodeJSON<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
        let decodedData = try JSONDecoder().decode(type, from: data)
        return decodedData
    }
}
