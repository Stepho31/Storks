//
//  NewMatchItemView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import SwiftUI

struct NewMatchItemView: View {
    let match: Match
    
    var body: some View {
        VStack {
            Image(match.user.profileImageURLs[0])
                .resizable()
                .scaledToFill()
                .frame(width: 96, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(match.user.firstName)
                .foregroundStyle(.black)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    NewMatchItemView(match: DeveloperPreview.matches[0])
}
