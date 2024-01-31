//
//  UserMatchView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import SwiftUI

struct UserMatchView: View {
    @Binding var show: Bool
    @EnvironmentObject var matchManager: MatchManager
    @EnvironmentObject var userManager: UserManager
        
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.7))
                .ignoresSafeArea()
            
            VStack(spacing: 120) {
                VStack {
                    Image(.itsamatch)
                    
                    if let matchedUser = matchManager.matchedUser {
                        Text("You and \(matchedUser.firstName) have liked each other.")
                            .foregroundStyle(.white)
                    }
                }
                                
                HStack(spacing: 16) {
                    CircularProfileImageView(user: userManager.currentUser, size: .xxxLarge)
                        .addBorder(.white.opacity(0.87))

                    CircularProfileImageView(user: matchManager.matchedUser, size: .xxxLarge)
                        .addBorder(.white.opacity(0.87))
                }
                               
                VStack(spacing: 16) {
                    NavigationLink(value: matchManager.matchedUser) {
                        Text("Send Message")
                            .modifier(TinderButtonModifier())
                    }
                    .simultaneousGesture(TapGesture().onEnded({
                        show.toggle()
                    }))
                    
                    Button {
                        show.toggle()
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
    UserMatchView(show: .constant(false))
}
