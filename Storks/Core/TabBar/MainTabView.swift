//
//  MainTabView.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var matchManager: MatchManager
    
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
//            SearchView()
//                .tabItem { Image(systemName: "magnifyingglass") }
//                .tag(1)
//                .onAppear { selection = 1 }
            
            InboxView()
                .tabItem {
                    Image(.messagesIcon)
                        .renderingMode(.template)
                }
                .tag(2)
                .onAppear { selection = 2 }
            
            UserCardsView(userManager: userManager, matchManager: matchManager)
                .tabItem { Image(.babyBottleIcon) }
                .tag(0)
                .onAppear { selection = 0 }
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(3)
                .onAppear { selection = 3 }
        }
        .tint(.primary)
    }
}

//#Preview {
//    MainTabView()
//        .environmentObject(UserManager(service: MockUserService()))
//}
