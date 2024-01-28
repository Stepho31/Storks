//
//  BackButton.swift
//  Tinder
//
//  Created by Brandon on 1/28/24.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: "chevron.left")
                .imageScale(.large)
                .fontWeight(.heavy)
                .foregroundStyle(.gray)
                .opacity(0.6)
        })
    }
}

#Preview {
    BackButton()
}
