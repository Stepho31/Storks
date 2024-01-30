//
//  MainTabView.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var matchManager: MatchManager
    
    var body: some View {
        TabView(selection: $selection) {
            UserCardsView(userManager: userManager, matchManager: matchManager)
                .tabItem { Image(systemName: "flame") }
                .tag(0)
                .onAppear { selection = 0 }
            
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)
                .onAppear { selection = 1 }
            
            InboxView()
                .tabItem {
                    Image(.messagesIcon)
                        .renderingMode(.template)
                }
                .tag(2)
                .onAppear { selection = 2 }
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(3)
                .onAppear { selection = 3 }
        }
        .tint(.white)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(UserManager(service: MockUserService()))
    }
}
