//
//  CardStackEmptyStateView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import SwiftUI

struct CardStackEmptyStateView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack(spacing: 24) {
            
            ZStack {
                Circle()
                    .fill(.purple.opacity(0.1))
                    .frame(width: 200, height: 200)
                
                Circle()
                    .fill(.purple.opacity(0.15))
                    .frame(width: 150, height: 150)
                
                CircularProfileImageView(user: userManager.currentUser, size: .xLarge)
            }
            
            Text("There's no one around you. Expand your discovery settings to see more people")
                .foregroundStyle(.gray)
                .font(.subheadline)
                .frame(width: 300)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CardStackEmptyStateView()
        .environmentObject(UserManager(service: MockUserService()))
}
