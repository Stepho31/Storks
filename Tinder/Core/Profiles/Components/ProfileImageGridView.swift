//
//  ProfileImageGridView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import SwiftUI
import Kingfisher

struct ProfileImageGridView: View {
    @EnvironmentObject var userManager: UserManager
    
    let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            if let user = userManager.currentUser {
                ForEach(0 ..< 6) { index in
                    if index < user.numberOfImages {
                        KFImage(URL(string: user.profileImageURLs[index]))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    } else {
                        ZStack(alignment: .bottomTrailing) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.secondarySystemBackground))
                                .frame(width: 110, height: 160)
                            
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .foregroundStyle(.white)
                                .offset(x: 8, y: 4)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileImageGridView()
        .environmentObject(UserManager(service: MockUserService()))
}
