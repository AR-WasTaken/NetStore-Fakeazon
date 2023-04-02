//
//  ContentView.swift
//  iOS-NetStore-With-API
//
//  Created by M on 20/03/2023.
//
import SwiftUI

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating

    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
}

//må bruke VAR hvis ikke er ikke koden "mutable"... og det blir en error...
struct Users: Codable, Identifiable {
    var id: Int
    var username: String
    var password: String
    var email: String
    var phone: String
    
    var name: Name?
    var address: Address?

    struct Name: Codable {
        var firstname: String
        var lastname: String
    }

    struct Address: Codable {
        var city: String
        var street: String
        var number: Int
        var zipcode: String
    }
}

//
struct Cart: Codable {
    let id: Int
    let userId: Int
    let date: String
    let products: [Product]
    let __v: Int
    
    struct Product: Codable {
        let productId: Int
        let quantity: Int
    }
}

struct ProductDetails: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
}



struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isLoggedIn = false
    @State var matchedUser: Users?
    
    @StateObject var dataFetcher = DataFetcher()
    
    let userId: Int?
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                ProductView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                CartView(userId: matchedUser?.id, isLoggedIn: $isLoggedIn/*, matchedUser: $matchedUser*/)
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Cart")
                    }
                    .tag(1)
                LoginView(isLoggedIn: $isLoggedIn, dataFetcher: dataFetcher, matchedUser: $matchedUser)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(2)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userId: 0)
    }
}
