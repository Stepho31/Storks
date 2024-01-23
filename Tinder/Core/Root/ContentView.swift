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
            if let userSessionId = authManager.userSessionId {
                if let user = userManager.currentUser {
                    MainTabView()
                }
            } else {
                LoginView(authManager: authManager)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
