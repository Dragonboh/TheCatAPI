//
//  CatsGridVM.swift
//  TheCatApi
//
//  Created by admin on 15.01.2025.
//

import SwiftUI


final class CatsGridVM: ObservableObject {
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        print("init CatsGridVM")
    }
  
    func getCats() async throws -> [CatModel] {
        print("download image")
        let cats = try await networkService.fetchCats()
        return cats
    }
}
