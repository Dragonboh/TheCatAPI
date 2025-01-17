//
//  MockURLProtocol 2.swift
//  TheCatApi
//
//  Created by admin on 17.01.2025.
//

@testable import TheCatApi

class MockNetworkService: NetworkServiceProtocol {
    
    let cats: [CatModel]
    let error: Error?
    
    init(cats: [CatModel], error: Error? = nil) {
        self.cats = cats
        self.error = error
    }
    
    func fetchCats() async throws -> [CatModel] {
        if let error = error {
            throw error
        }
        
        return cats
    }
}
