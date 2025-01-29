//
//  CatsGridView.swift
//  TheCatApi
//
//  Created by admin on 27.01.2025.
//

import SwiftUI
import Kingfisher

struct CatsGridView: View {
    
    @ObservedObject var viewModel: CatsViewModel
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120, maximum: 120), spacing: nil, alignment: nil)
    ]
    
    var body: some View {
        if viewModel.cats.isEmpty {
            VStack {
                Spacer()
                ProgressView()
                    .frame(width: 50, height: 50)
                Spacer()
            }
            
        } else {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.isSearching ? Array(viewModel.filteredCats.enumerated()) : Array(viewModel.cats.enumerated()), id: \.offset) { tuple in
                        NavigationLink(value: tuple.element) {
                            KFImage.url(URL(string: tuple.element.url))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipped()
                                .background(Color.red)
                        }
                    }
                    
                    if !viewModel.isEnd {
                        ProgressView()
                            .onAppear() {
                                Task {
                                    try await viewModel.loadMore()
                                }
                            }
                    }
                }
            }
        }
    }
}
