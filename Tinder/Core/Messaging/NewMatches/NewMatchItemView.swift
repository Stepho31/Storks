//
//  NewMatchItemView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import SwiftUI
import Kingfisher

struct NewMatchItemView: View {
    let match: Match
    
    var body: some View {
        VStack {
            if let user = match.user {
                KFImage(URL(string: user.profileImageURLs[0]))
//                Image(user.profileImageURLs[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 96, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(user.firstName)
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    NewMatchItemView(match: DeveloperPreview.matches[0])
}
