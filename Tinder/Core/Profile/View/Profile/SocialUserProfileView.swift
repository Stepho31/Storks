//
//  SocialUserProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import SwiftUI

struct SocialUserProfileView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            LazyVStack {
                CircularProfileImageView(user: user, size: .xLarge)
                
                VStack(spacing: 4) {
                    Text(user.fullname)
                        .font(.title3)
                    
                    if let bio = user.bio {
                        Text(bio)
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                    }
                    
                    Text(user.major + " " + String(user.graduationYear))
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    SocialUserProfileView(user: DeveloperPreview.user)
}
