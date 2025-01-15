//
//  ContentView.swift
//  TheCatApi
//
//  Created by admin on 15.01.2025.
//

import SwiftUI

struct CatsGrid: View {
    let viewModel = CatsGridVM()
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            if image == nil {
                Text("Loading...")
            } else {
                Image(uiImage: image!)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
        }
        .padding()
        .onAppear() {
            Task {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                image = try await viewModel.getCatImage()
            }
        }
    }
}

#Preview {
    CatsGrid()
}
