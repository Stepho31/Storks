//
//  CloseButton.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/31/24.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: { dismiss() }, label: {
            Image(systemName: "xmark")
                .imageScale(.large)
                .foregroundStyle(Color(.primaryText))
        })
    }
}

#Preview {
    CloseButton()
}
