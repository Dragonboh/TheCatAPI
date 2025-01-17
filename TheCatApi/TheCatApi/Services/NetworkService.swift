//
//  NetworkService.swift
//  TheCatApi
//
//  Created by admin on 16.01.2025.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

protocol NetworkServiceProtocol {
    func fetchCats() async throws -> [CatModel]
}

final class NetworkService: NetworkServiceProtocol {
    
    private let apiKey = "live_nzBOaDeUlBEAD4fn9Hu8PC58oXSNfDBpZAKPA2Myyt3Z1BPNCrkEr8skuHVibysw"
    private let baseURL = "https://api.thecatapi.com/v1/images/search"
    
    func fetchCats() async throws -> [CatModel] {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
          URLQueryItem(name: "order", value: "DESC"),
          URLQueryItem(name: "limit", value: "50"),
          URLQueryItem(name: "has_breeds", value: "1"),
        ]
        
        guard let url = components?.url else {
            throw CustomError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        let cats = try  JSONDecoder().decode([CatModel].self, from: data)
        return cats
    }
}
