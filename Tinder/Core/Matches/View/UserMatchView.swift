//
//  UserMatchView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import SwiftUI

struct UserMatchView: View {
    @Binding var show: Bool
    @ObservedObject var cardsViewModel: CardsViewModel
        
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 120) {
                VStack {
                    Image(.itsamatch)
                    
                    if let matchedUser = cardsViewModel.matchedUser {
                        Text("You and \(matchedUser.firstName) have liked each other.")
                            .foregroundStyle(.white)
                    }
                }
                                
                HStack(spacing: 16) {
                    CircularProfileImageView(user: cardsViewModel.currentUser, size: .xxxLarge)
                        .addBorder(.white.opacity(0.87))

                    CircularProfileImageView(user: cardsViewModel.matchedUser, size: .xxxLarge)
                        .addBorder(.white.opacity(0.87))
                }
                               
                VStack(spacing: 16) {
                    Button {
                        show.toggle()
                        cardsViewModel.matchedUser = nil
                    } label: {
                        Text("Send Message")
                            .modifier(TinderButtonModifier())
                    }
                    
                    Button {
                        show.toggle()
                        cardsViewModel.matchedUser = nil
                    } label: {
                        Text("Keep Swiping")
                            .modifier(TinderButtonModifier(backgroundColor: .clear))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 1.0)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    UserMatchView(
        show: .constant(false),
        cardsViewModel: CardsViewModel(userManager: UserManager(service: MockUserService()))
    )
}
