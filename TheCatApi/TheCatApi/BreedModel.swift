//
//  BreedModel.swift
//  TheCatApi
//
//  Created by admin on 16.01.2025.
//


struct BreedModel: Codable, Identifiable {
    let id: String
    let name: String
    let temperament: String
    let description: String
    let origin: String
}
