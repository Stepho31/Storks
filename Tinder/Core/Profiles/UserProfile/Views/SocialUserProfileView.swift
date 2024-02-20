//
//  SocialUserProfileView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import SwiftUI
import Kingfisher

struct SocialUserProfileView: View {
    @State private var showProfilePhotosTabView = false
    
    let user: User
    private let items = Array(repeating: GridItem(.flexible(), spacing:1), count: 3)
    private let width = (UIScreen.main.bounds.width / 3) - 2
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                CircularProfileImageView(user: user, size: .xxxLarge)
                
                VStack(spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                        
                        Text(user.major + " | " + String(user.graduationYear))
                            .foregroundStyle(.gray)
                        
                        Text(user.gender.description + " | " + user.sexualOrientation.description)
                            .foregroundStyle(.gray)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Divider()
                            
                            if let bio = user.bio {
                                Text(bio)
                                
                                Divider()
                            }
                        }
                        .padding(.top)
                    }
                    .font(.subheadline)
                    .padding()

                    LazyVGrid(columns: items, spacing: 2) {
                        ForEach(user.profileImageURLs, id: \.self) { imageUrl in
                            if imageUrl != user.profileImageURLs.first {
                                KFImage(URL(string: imageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: width, height: width)
                                    .clipped()
                                    .onTapGesture { showProfilePhotosTabView.toggle() }
                            }
                        }
                    }
                }
            }
        }
        .padding(.top)
        .navigationTitle(user.firstName)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showProfilePhotosTabView, content: {
            ProfilePhotosTabView(user: user)
        })
        .toolbar(.hidden, for: .tabBar)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SocialUserProfileView(user: DeveloperPreview.user)
        .preferredColorScheme(.dark)
}
