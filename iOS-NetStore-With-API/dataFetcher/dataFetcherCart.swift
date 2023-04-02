//
//  dataFetcherCart.swift
//  iOS-NetStore-With-API
//
//  Created by Max Christopher Romslo Schulstock on 02/04/2023.
//

import Foundation
import SwiftUI

struct dataFetcherCart {
    static func fetchData(userId: Int, completion: @escaping (Cart?) -> Void) {
        let urlString = "https://fakestoreapi.com/carts/\(userId)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let fetchedData = try decoder.decode(Cart.self, from: data)
                    print("Fetched cart data: \(fetchedData)")
                    completion(fetchedData)
                } catch {
                    print("Error decoding data: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }


    static func fetchProductData(productId: Int, completion: @escaping (ProductDetails?) -> Void) {
        let urlString = "https://fakestoreapi.com/products/\(productId)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let fetchedData = try decoder.decode(ProductDetails.self, from: data)
                    completion(fetchedData)
                } catch {
                    print("Error decoding data: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }
}
