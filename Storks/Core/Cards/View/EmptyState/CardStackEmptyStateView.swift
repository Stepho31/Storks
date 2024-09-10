//
//  CardStackEmptyStateView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import SwiftUI

struct CardStackEmptyStateView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var cardsViewModel: CardsViewModel
    
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
            
            VStack {
                Text("It looks like you've seen everyone.")
                Text("Click below to see people you swiped left on again.")
            }
            .foregroundStyle(.gray)
            .font(.subheadline)
            .frame(width: 300)
            .multilineTextAlignment(.center)
            
            Button {
                Task { await cardsViewModel.resetCards() }
            } label: {
                Text("Start Over")
                    .modifier(TinderButtonModifier())
            }
        }
    }
}

#Preview {
    CardStackEmptyStateView()
        .environmentObject(UserManager(service: MockUserService()))
        .environmentObject(CardsViewModel(currentUser: DeveloperPreview.user,
                                          cardService: MockCardService(),
                                          matchManager: MatchManager(service: MatchService())))
}
