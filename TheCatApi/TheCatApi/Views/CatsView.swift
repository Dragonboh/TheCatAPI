//
//  ContentView.swift
//  TheCatApi
//
//  Created by admin on 15.01.2025.
//


import SwiftUI

struct CatsView: View {
    @StateObject private var viewModel = CatsViewModel(networkService: NetworkService())

    var body: some View {
        NavigationStack{
            CatsGridView(viewModel: viewModel)
                .backgroundStyle(Color.blue)
                .searchable(text: $viewModel.searchText, prompt: Text("Search by breeds"))
                .navigationDestination(for: CatModel.self) { cat in
                    CatDetailsView(cat: cat)
                }
                .navigationTitle("Cats")
                .navigationBarTitleDisplayMode(.inline)
                .task {
                    Task {
                        if viewModel.cats.isEmpty {
                            try await viewModel.getCats()
                        }
                    }
                }
        }
    }
}

#Preview {
    CatsView()
}
