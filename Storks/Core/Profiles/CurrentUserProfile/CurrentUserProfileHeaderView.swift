//
//  CurrentUserProfileHeaderView.swift
//  Tinder
//
//  Created by Stephan Dowless on 3/8/24.
//

import SwiftUI

struct CurrentUserProfileHeaderView: View {
    @Binding var showEditProfile: Bool
    let user: User
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                CircularProfileImageView(user: user, size: .xxLarge)
                    .background {
                        Circle()
                            .fill(Color(.systemGray6))
                            .frame(width: 128, height: 128)
                            .shadow(radius: 10)
                    }
                
                Image(systemName: "pencil")
                    .imageScale(.small)
                    .foregroundStyle(.gray)
                    .background {
                        Circle()
                            .fill(.white)
                            .frame(width: 32, height: 32)
                    }
                    .offset(x: -8, y: 10.0)
            }
            .onTapGesture { showEditProfile.toggle() }
            
            Text("\(user.firstName), \(user.age)")
                .font(.title2)
                .fontWeight(.light)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 240)
        .background(.white.opacity(0.01))
    }
}

#Preview {
    CurrentUserProfileHeaderView(showEditProfile: .constant(false), user: DeveloperPreview.user)
}
