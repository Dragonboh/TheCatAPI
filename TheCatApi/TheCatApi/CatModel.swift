//
//  CatModel.swift
//  TheCatApi
//
//  Created by admin on 16.01.2025.
//


struct CatModel: Codable, Identifiable {
    let id: String
    let url: String
    let breeds: [BreedModel]
}
