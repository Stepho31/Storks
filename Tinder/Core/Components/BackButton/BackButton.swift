//
//  BackButton.swift
//  Tinder
//
//  Created by Brandon on 1/28/24.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: { dismiss() }, label: {
            Image(systemName: "chevron.left")
                .imageScale(.large)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
        })
    }
}

#Preview {
    BackButton()
}
