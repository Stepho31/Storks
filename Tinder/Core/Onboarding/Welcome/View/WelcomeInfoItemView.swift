//
//  WelcomeInfoItemView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/23/24.
//

import SwiftUI

struct WelcomeInfoItemView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            Text(subtitle)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.subheadline)
    }
}

#Preview {
    Group {
        WelcomeInfoItemView(title: "Be yourself.", subtitle: "Make sure your photos, age, and bio are true to who you are.")
        WelcomeInfoItemView(title: "Be proactive.", subtitle: "Always report bad behavior.")
    }

}
