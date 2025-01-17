//
//  CatModel.swift
//  TheCatApi
//
//  Created by admin on 16.01.2025.
//

import Foundation

struct CatModel: Codable, Identifiable, Hashable {
    let id = UUID()
    let serverId: String
    let url: String
    let breeds: [BreedModel]
    
    private enum CodingKeys: String, CodingKey {
        case serverId = "id"
        case url
        case breeds
    }
}

extension CatModel {
    static let mockCat = CatModel(
        serverId: "0XYvRd7oD",
        url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg",
        breeds: [BreedModel(serverID: "abys",
                            name: "Abyssinian",
                            temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                            description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
                            origin: "Egypt")]
    )
}
