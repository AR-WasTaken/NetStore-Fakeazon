//
//  ProductView.swift
//  iOS-NetStore-With-API
//
//  Created by Max Christopher Romslo Schulstock on 02/04/2023.
//

import Foundation
import SwiftUI

struct ProductView: View {
    @StateObject var dataFetcher = DataFetcher()
    
    let categories = ["All", "men's clothing", "women's clothing", "jewelery", "electronics"]
    
    @State private var selectedCategory = "All"

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category.capitalized)
                                    .padding(-2)
                                    .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10))
                            }
                            .buttonStyle(BorderedProminentOrBordered(isProminent: selectedCategory == category))
                        }
                    }
                    .padding(.horizontal)
                }
                
                List(filteredProducts()) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductRowView(product: product)
                    }
                }
                .onAppear {
                    dataFetcher.fetchProducts()
                }
                .navigationTitle("Fakeazon")
            }
        }
        .background(Color.gray)
    }
    
    func filteredProducts() -> [Product] {
        guard selectedCategory != "All" else {
            return dataFetcher.products
        }
        
        return dataFetcher.products.filter { $0.category.lowercased() == selectedCategory.lowercased() }
    }
}

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image)) { image in image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text("$\(product.price, specifier: "%.2f")")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 7)
    }
}

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        
        NavigationView {
            List {
                VStack(alignment: .center, spacing: 16) {
                    AsyncImage(url: URL(string: product.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 304.0)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(product.title)
                        .font(.largeTitle)
                    
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title)
                        .foregroundColor(.gray)
                    
                    Text("Description")
                        .font(.headline)
                    
                    Text(product.description)
                        .font(.body)
                    
                    Text("Category")
                        .font(.headline)
                    
                    Text(product.category)
                        .font(.body)
                    
                    Text("Rating")
                        .font(.headline)
                    
                    HStack {
                        Text("\(product.rating.rate, specifier: "%.1f")")
                            .font(.body)
                        Text("(\(product.rating.count) reviews)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                }
            }
        }
        .padding(.top, -225)
    }
}
