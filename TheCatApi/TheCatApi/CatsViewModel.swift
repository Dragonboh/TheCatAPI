//
//  CatsGridVM.swift
//  TheCatApi
//
//  Created by admin on 15.01.2025.
//

import SwiftUI
import Combine

@MainActor
final class CatsViewModel: ObservableObject {
    
    
    @Published private(set) var cats: [CatModel] = []
    @Published private(set) var filteredCats: [CatModel] = []
    @Published var searchText: String = ""
    
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        addSubscribers()
        print("init CatsGridVM")
    }
    
    var isEnd: Bool {
        currentPage == 3
    }
    
    var visibleData: [(Int, CatModel)] {
        isSearching
        ? Array(filteredCats.enumerated())
        : Array(cats.enumerated()) 
    }
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    func loadMore() async throws {
        print("load more images")
        let nextPage = currentPage + 1
        let moreCats = try await networkService.fetchCats(page: nextPage)
        cats.append(contentsOf: moreCats)
        currentPage = nextPage
    }
    
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.searchCats(breedSearch: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func searchCats(breedSearch: String) {
        guard !breedSearch.isEmpty else {
            filteredCats = cats
            return
        }
        
        filteredCats = cats.filter({ cat in
            cat.breeds.contains { breed in
                breed.name.lowercased() == breedSearch.lowercased()
            }
        })
    }
  
    func getCats() async throws {
        print("download image")
        currentPage = 1
        cats = try await networkService.fetchCats(page: currentPage)
    }
}
