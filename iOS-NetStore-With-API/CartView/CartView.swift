//
//  CartView.swift
//  iOS-NetStore-With-API
//
//  Created by Max Christopher Romslo Schulstock on 02/04/2023.
//

import Foundation
import SwiftUI

struct CartView: View {
    let userId: Int?
    @Binding var isLoggedIn: Bool
    @State private var cart: Cart?
    @State private var productDetailsList: [ProductDetails] = []

    var body: some View {
        NavigationView {
            VStack {
                if !isLoggedIn {
                    Text("Please log in :)")
                } else {
                    cartContent
                }
            }
            .navigationTitle("Cart")
            .onAppear(perform: loadCartData)
        }
    }

    private var cartContent: some View {
        ScrollView {
            VStack {
                if cart != nil {
                    ForEach(productDetailsList, id: \.id) { productDetails in
                        cartItem(productDetails: productDetails)
                    }
                } else {
                    Text("Loading data...")
                }
            }
        }
    }

    private func cartItem(productDetails: ProductDetails) -> some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: productDetails.image)) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 80.0)
                } placeholder: {
                    ProgressView()
                }

                VStack(alignment: .leading) {
                    Text(productDetails.title).font(.headline)
                    Text("$\(productDetails.price, specifier: "%.2f")").foregroundColor(.gray)
                }
                .padding(.vertical, 30)
            }
            .padding(.horizontal, 20)

            Divider()
        }
    }

    private func loadCartData() {
        if let userId = self.userId {
            dataFetcherCart.fetchData(userId: userId) { fetchedData in
                DispatchQueue.main.async {
                    self.cart = fetchedData

                    if let products = fetchedData?.products {
                        for product in products {
                            dataFetcherCart.fetchProductData(productId: product.productId) { fetchedProductDetails in
                                DispatchQueue.main.async {
                                    if let fetchedProductDetails = fetchedProductDetails {
                                        self.productDetailsList.append(fetchedProductDetails)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func quantityForProduct(withId id: Int) -> Int {
        return cart?.products.first(where: { $0.productId == id })?.quantity ?? 0
    }
}
