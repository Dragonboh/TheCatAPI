//
//  ContentView.swift
//  TheCatApi
//
//  Created by admin on 15.01.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("cats")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
