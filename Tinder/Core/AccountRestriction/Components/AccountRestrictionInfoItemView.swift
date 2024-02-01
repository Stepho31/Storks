//
//  AccountRestrictionInfoItemView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/31/24.
//

import SwiftUI

struct AccountRestrictionInfoItemView: View {
    let imageName: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: imageName)
                .frame(width: 24)
                .font(.title3)
                                
            Text(description)
                .font(.subheadline)
        }
    }
}

#Preview {
    AccountRestrictionInfoItemView(imageName: "info.circle",
                                   description: "Understand problems people are having with different types of content on Tinder.")
}
