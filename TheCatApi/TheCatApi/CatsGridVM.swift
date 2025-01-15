//
//  CatsGridVM.swift
//  TheCatApi
//
//  Created by admin on 15.01.2025.
//

import SwiftUI

enum CustomError: Error {
    case invalidURL
    case invalidData
}

final class CatsGridVM {
    
    func getCatImage() async throws -> UIImage {
        
        guard let url = URL(string: "https://cdn2.thecatapi.com/images/26c.jpg") else {
            throw CustomError.invalidURL
        }
        
//        let data = URLSession.shared.dataTask(with: url).awakeFromNib().wait()
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw CustomError.invalidData
        }
        
        return image
    }
}
