//
//  BreedModel.swift
//  TheCatApi
//
//  Created by admin on 16.01.2025.
//

import Foundation

struct BreedModel: Codable, Identifiable, Hashable {
    let id = UUID()
    let serverID: String
    let name: String
    let temperament: String
    let description: String
    let origin: String
    
    private enum CodingKeys: String, CodingKey {
        case serverID = "id"
        case name
        case temperament
        case description
        case origin
    }
}
