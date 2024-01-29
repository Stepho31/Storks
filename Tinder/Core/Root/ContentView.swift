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
    @State private var didCompleteOnboarding = false
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .unauthenticated:
                AuthenticationRootView()
            case .authenticated:
                if didCompleteOnboarding {
                    if userManager.currentUser != nil {
                        MainTabView()
                    }
                } else {
                    WelcomeView(didCompleteOnboarding: $didCompleteOnboarding)
                }
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
