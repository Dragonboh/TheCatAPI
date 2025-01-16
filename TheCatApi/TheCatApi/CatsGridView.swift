//
//  ContentView.swift
//  TheCatApi
//
//  Created by admin on 15.01.2025.
//



import SwiftUI

struct CatsGridView: View {
    let viewModel = CatsGridVM(networkService: NetworkService())
    @State var image: UIImage?
    @State var cats: [CatModel] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    
    var body: some View {
        ScrollView {
//            LazyVStack {
//                ForEach(cats) { cat in
//                    HStack {
//                        AsyncImage(url: URL(string: cat.url)) { image in
//                            image
//                                .resizable()
//                                .scaledToFit()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .frame(width: 100, height: 100)
//                        .background(Color.red)
//                        
//                        Text(cat.id)
//                            .fontWeight(.semibold)
//                            .frame(height: 20)
//                            .padding(.horizontal)
//                        
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//                    
//                }
//            }
            LazyVGrid(columns: columns) {
                ForEach(cats) { cat in
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
        }
        .onAppear {
            Task {
                //try await Task.sleep(nanoseconds: 1_000_000_000)
                cats = try await viewModel.getCats()
                print("11")
            }
        }
        
    }
}

#Preview {
    CatsGridView()
}


//VStack {
//    Text("asdasd")
//        .fontWeight(.semibold)
//        .frame(height: 20)
//        .padding(.horizontal)
//    ScrollView {
//        LazyVStack {
//            ForEach(cats) { cat in
//                HStack {
//                    AsyncImage(url: URL(string: cat.url)) { image in
//                        image
//                            .resizable()
//                            .scaledToFit()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .frame(width: 100, height: 100)
//                    .background(Color.red)
//
//                    Text(cat.id)
//                        .fontWeight(.semibold)
//                        .frame(height: 20)
//                        .padding(.horizontal)
//                    
//                    Spacer()
//                }
//                .padding(.horizontal)
//                
//            }
//        }
//    }
//}
//.onAppear {
//    Task {
////                try await Task.sleep(nanoseconds: 1_000_000_000)
//        cats = try await viewModel.getCats()
//        print("11")
//    }
//}
