//
//  LoginView.swift
//  iOS-NetStore-With-API
//
//  Created by Max Christopher Romslo Schulstock on 02/04/2023.
//

import Foundation
import SwiftUI

struct LoginView: View {
 
    @Binding var isLoggedIn: Bool
    @StateObject var dataFetcher = DataFetcher()
    @State var username = ""
    @State var password = ""
    @State var email = ""
    @State var users = [Users]()
    @State var showAlert = false
    @Binding var matchedUser: Users?
     
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                HStack {
                    Button(action: {
                        username = "johnd"
                        password = "m38rmF$"
                    }) {
                        Text("John")
                    }
                    Button(action: {
                        username = "mor_2314"
                        password = "83r5^_"
                    }) {
                        Text("Morrison")
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email or Username")
                        .font(.headline)
                    TextField("Enter your email or username", text: $username)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Password")
                        .font(.headline)
                    SecureField("Enter your password", text: $password)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: {
                    let matchingUsers = dataFetcher.users.filter { $0.username == username || $0.email == username }
                    if let matchedUser = matchingUsers.first, matchedUser.password == password {
                        isLoggedIn = true
                        self.matchedUser = matchedUser
                        username = ""
                        password = ""
                    } else {
                        self.showAlert = true
                    }
                }) {
                    Text(isLoggedIn ? "Logout" : "Login")
                        .padding(.vertical, 13)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Incorrect Username/Email or Password"), dismissButton: .default(Text("OK")))
                }
                
                if isLoggedIn {
                    NavigationLink(destination: ProfileView(isLoggedIn: $isLoggedIn, matchedUser: $matchedUser)) {
                        Text("Go to Profile")
                    }
                }
            }
            .padding(.horizontal, 24)
            .onAppear {
                print("LoginView Appeared")
                dataFetcher.fetchUsers()
                print(dataFetcher)
                print(dataFetcher.fetchUsers)
            }
        }
    }
}
