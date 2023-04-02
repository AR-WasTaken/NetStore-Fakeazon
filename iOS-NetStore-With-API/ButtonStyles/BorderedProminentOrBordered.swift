//
//  File.swift
//  iOS-NetStore-With-API
//
//  Created by Max Christopher Romslo Schulstock on 02/04/2023.
//

import Foundation
import SwiftUI

struct BorderedProminentOrBordered: ButtonStyle {
    var isProminent: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isProminent ? Color.blue : Color(red: 0.97, green: 0.96, blue: 0.99))
            .foregroundColor(isProminent ? Color(red: 0.97, green: 0.96, blue: 0.99) : Color.blue)
            .overlay (
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isProminent ? Color.blue : Color(red: 0.97, green: 0.96, blue: 0.99), lineWidth: 2)
                )
            .cornerRadius(10)
    }
}
