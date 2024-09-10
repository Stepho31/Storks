//
//  TinderTextFieldModifier.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import SwiftUI

struct TinderTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}
