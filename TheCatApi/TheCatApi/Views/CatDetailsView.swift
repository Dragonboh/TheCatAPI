//
//  CatDetailsView.swift
//  TheCatApi
//
//  Created by admin on 16.01.2025.
//

import SwiftUI

struct CatDetailsView: View {
    let cat: CatModel
    
    init(cat: CatModel) {
        self.cat = cat
        print("333")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: URL(string: cat.url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    //                        .aspectRatio(contentMode: .fill)
                    //                        .frame(height:400)
                } placeholder: {
                    ProgressView()
                        .foregroundStyle(Color.blue)
                }
                .frame(height:400)
                //                .background(Color.red)
                
                ForEach(cat.breeds) { breed in
                    VStack(alignment: .leading, spacing: 10) {
                        BreedDetailsRowView(title: "Breed name", text: breed.name)
                        BreedDetailsRowView(title: "Origin", text: breed.origin)
                        BreedDetailsRowView(title: "Temperament", text: breed.temperament)
                        BreedDetailsRowView(title: "Description", text: breed.description)
                    }
                    .padding(.horizontal)
                    
                }
                
                Spacer()
            }
        }
        .navigationTitle("asdads")
    }
}

#Preview {
    CatDetailsView(cat: CatModel.mockCat)
}

struct BreedDetailsRowView: View {
    let title: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(attributedText)
        }
    }
    
    var attributedText: AttributedString {
        var firstPart = AttributedString("\(title):  ")
        firstPart.font = Font.system(size: 16, weight: .semibold)
        
        var secondPart = AttributedString(text)
        secondPart.font = .subheadline
        
        firstPart.append(secondPart)
        return firstPart
    }
}
