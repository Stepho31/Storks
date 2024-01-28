//
//  ContentView.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        Group {
            if authManager.userSessionId != nil {
                if userManager.currentUser != nil {
                    MainTabView()
                }
            } else {
                AuthenticationRootView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthManager(service: MockAuthService()))
            .environmentObject(UserManager(service: MockUserService()))
    }
}
