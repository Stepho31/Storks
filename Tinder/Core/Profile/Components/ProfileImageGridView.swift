//
//  ProfileImageGridView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import SwiftUI

struct ProfileImageGridView: View {
//    let user: User
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
                        Image(user.profileImageURLs[index])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    } else {
                        Rectangle()
                            .fill(Color(.systemGroupedBackground))
                            .frame(width: 110, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileImageGridView()
}
