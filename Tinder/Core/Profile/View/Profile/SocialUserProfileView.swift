//
//  SocialUserProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import SwiftUI

struct SocialUserProfileView: View {
    let user: User
    private let items = Array(repeating: GridItem(.flexible(), spacing:1), count: 3)
    private let width = (UIScreen.main.bounds.width / 3) - 2
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Image(user.profileImageURLs.first ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 500)
                
                VStack(spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                        
                        Text(user.major + " | " + String(user.graduationYear))
                            .foregroundStyle(.gray)
                        
                        Text(user.gender.description + " | " + "Seeking \(user.sexualPreference.description)")
                            .foregroundStyle(.gray)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Divider()
                            if let bio = user.bio { Text(bio) }
                            Divider()
                        }
                        .padding(.top)
                    }
                    .font(.subheadline)
                    .padding()

                    LazyVGrid(columns: items, spacing: 2) {
                        ForEach(user.profileImageURLs, id: \.self) { imageUrl in
                            if imageUrl != user.profileImageURLs.first {
                                Image(imageUrl)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: width, height: width)
                                    .clipped()
                            }
                        }
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .scrollIndicators(.hidden)
        .ignoresSafeArea()
    }
}

#Preview {
    SocialUserProfileView(user: DeveloperPreview.user)
        .preferredColorScheme(.dark)
}
