//
//  ContentView.swift
//  TheCatApi
//
//  Created by admin on 15.01.2025.
//



import SwiftUI

struct CatsGridView: View {
    @StateObject var viewModel = CatsGridVM(networkService: NetworkService())
    @State private var cats: [CatModel] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]

    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(cats) { cat in
//                        NavigationLink {
//                            CatDetailsView(cat: cat)
//                        } label: {
//                            AsyncImage(url: URL(string: cat.url)) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFit()
//                            } placeholder: {
//                                ProgressView()
//                                    .foregroundStyle(Color.blue)
//                            }
//                            .frame(height: 120)
//                            .background(Color.red)
//                        }
                        NavigationLink(value: cat) {
                            AsyncImage(url: URL(string: cat.url)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                                    .foregroundStyle(Color.blue)
                            }
                            .frame(height: 120)
                            .background(Color.red)
                        }
                    }
                } .task {
                    Task {
                        if cats.isEmpty {
                            print("11")
                            cats = try await viewModel.getCats()
                            print("22")
                        }
                    }
                }
                
            }
           
            .navigationDestination(for: CatModel.self) { cat in
                CatDetailsView(cat: cat)
            }
            .navigationTitle("Cats")
//            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    CatsGridView()
}
