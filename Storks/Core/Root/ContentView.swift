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
            switch authManager.authState {
            case .unauthenticated:
                AuthenticationRootView()
                    .environmentObject(AuthViewModel())
            case .authenticated:
                if userManager.isLoading {
                    ProgressView()
                } else {
                    if let user = userManager.currentUser, user.didCompleteOnboarding {
                        MainTabView()
                    } else {
                        WelcomeView()
                    }
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
