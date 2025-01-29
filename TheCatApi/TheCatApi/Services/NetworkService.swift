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
    func fetchCats(page: Int) async throws -> [CatModel]
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchCats(page: Int = 1) async throws -> [CatModel] {
        var components = URLComponents(string: NetworkConstants.baseURL)
        components?.queryItems = [
          URLQueryItem(name: "order", value: "DESC"),
          URLQueryItem(name: "limit", value: "50"),
          URLQueryItem(name: "has_breeds", value: "1"),
          URLQueryItem(name: "page", value: "\(page)"),
        ]

        let cats = try await performRequest(url: components?.url, returneType: [CatModel].self)
       
        return cats
    }
}

private extension NetworkService {
    func performRequest<T: Decodable>(url: URL?, returneType: T.Type) async throws -> T {
        let request = try createRequest(url: url)
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        let returnedData = try Utilities.decodeJSON(returneType, data: data)
        return returnedData
    }
    
    func createRequest(url: URL?) throws -> URLRequest {
        guard let url = url else {
            throw CustomError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue(NetworkConstants.apiKey, forHTTPHeaderField: "x-api-key")
        
        return request
    }
        
}
