//
//  ContentView.swift
//  TheCatApi
//
//  Created by admin on 15.01.2025.
//



import SwiftUI
import Kingfisher

struct CatsGridView: View {
    @StateObject var viewModel = CatsGridVM(networkService: NetworkService())
    @State private var cats: [CatModel] = []
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100, maximum: 100), spacing: nil, alignment: nil)
//        GridItem(.flexible(minimum: 120, maximum: 120), spacing: nil, alignment: nil),
//        GridItem(.flexible(minimum: 120, maximum: 120), spacing: nil, alignment: nil)
    ]

    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(cats) { cat in
                        NavigationLink(value: cat) {
                            KFImage.url(URL(string: cat.url))
                                .resizable() 
                                .scaledToFit()
                                .frame(height: 100)
                                .background(Color.red)
                            
                            
//                            AsyncImage(url: URL(string: cat.url)) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFit()
//                            } placeholder: {
//                                ProgressView()
//                                    .foregroundStyle(Color.blue)
//                            }
                            
                        }
                    }
                }
                .padding()
                .task {
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
