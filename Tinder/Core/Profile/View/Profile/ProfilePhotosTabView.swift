//
//  ProfilePhotosTabView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/31/24.
//

import SwiftUI
import Kingfisher

struct ProfilePhotosTabView: View {
    let user: User
    
    var body: some View {
        TabView {
            ForEach(user.profileImageURLs, id: \.self) { imageUrl in
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 500)
                    .clipped()
            }
        }
        .overlay(alignment: .topLeading) {
            CloseButton()
                .padding()
        }
        .background(.black)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

#Preview {
    ProfilePhotosTabView(user: DeveloperPreview.user)
}
