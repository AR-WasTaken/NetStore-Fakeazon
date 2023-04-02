//
//  dataFetcher.swift
//  iOS-NetStore-With-API
//
//  Created by Max Christopher Romslo Schulstock on 02/04/2023.
//

import Foundation
import SwiftUI

class DataFetcher: ObservableObject {
    @Published var products: [Product] = []
    @Published var users: [Users] = []

    func fetchProducts() {
        let urlString = "https://fakestoreapi.com/products"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let products = try decoder.decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        self.products = products
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    func fetchUsers() {
        let urlString = "https://fakestoreapi.com/users"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([Users].self, from: data)
                    DispatchQueue.main.async {
                        self.users = users
                        print("Fetched Users: \(users)")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
