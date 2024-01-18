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
    
    var body: some View {
        TabView(selection: $selection) {
            CardStackView(userManager: userManager)
                .tabItem { Image(systemName: "flame") }
                .tag(0)
                .onAppear { selection = 0 }
            
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(0)
                .onAppear { selection = 0 }
            
            InboxView()
                .tabItem {
                    Image(.messagesIcon)
                        .renderingMode(.template)
                }
                .tag(1)
                .onAppear { selection = 1 }
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(2)
                .onAppear { selection = 2 }
        }
        .tint(.purple)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(UserManager(service: MockUserService()))
    }
}
