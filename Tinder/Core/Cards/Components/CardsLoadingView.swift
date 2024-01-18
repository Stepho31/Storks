//
//  CardsLoadingView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import SwiftUI

struct CardsLoadingView: View {
    @State private var animationAmount = 1.0
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .fill(.purple.opacity(0.1))
                    .frame(width: 200, height: 200)
                    .scaleEffect(animationAmount)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                        value: animationAmount
                    )
                
                Circle()
                    .fill(.purple.opacity(0.15))
                    .frame(width: 150, height: 150)
                
                CircularProfileImageView(user: userManager.currentUser, size: .xLarge)
            }
        }
        .onAppear { animationAmount = 1.25 }
    }
}

#Preview {
    CardsLoadingView()
        .environmentObject(UserManager(service: MockUserService()))
}
