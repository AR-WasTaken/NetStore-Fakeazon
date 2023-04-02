//
//  ProfileView.swift
//  iOS-NetStore-With-API
//
//  Created by Max Christopher Romslo Schulstock on 02/04/2023.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @Binding var isLoggedIn: Bool
    @Binding var matchedUser: Users?
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    if let matchedUser = matchedUser {
                        displayUserInfo(for: matchedUser)
                    }
                } else {
                    Text("You are not logged in")
                }
                
                Spacer()
            }
        }
    }
    
    
    private func displayUserInfo(for user: Users) -> some View {
        List {
            VStack(alignment: .center, spacing: 16) {
                if let name = user.name {
                    Text("\(name.firstname) \(name.lastname)")
                        .font(.largeTitle)
                        .autocapitalization(.none)
               }
                Text("Email")
                    .font(.headline)
                
                Text(user.email)
                    .font(.body)
                    .foregroundColor(.gray)
                
                Text("Location")
                    .font(.headline)
                
                Text(user.address?.city ?? "")
                    .font(.body)
                    .foregroundColor(.gray)
                
                Text("Street / Zipcode")
                    .font(.headline)
                
                HStack {
                    Text(user.address?.street ?? "")
                        .font(.body)
                        .foregroundColor(.gray)

                    Text("\(user.address?.number ?? 0)")
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    Text(user.address?.zipcode ?? "")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                
                Text("Phone")
                    .font(.headline)
                
                Text(user.phone)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
    }
}
