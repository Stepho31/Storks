//
//  AuthenticationRootView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/22/24.
//

import SwiftUI

struct AuthenticationRootView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                AuthenticationTopView()
                
                Spacer()
                
                AuthenticationBottomView(authType: $authManager.authType, authViewModel: authViewModel)
            }
            .fullScreenCover(item: $authManager.authType, content: { _ in
                EmailView()
                    .environmentObject(authManager)
                    .environmentObject(authViewModel)
            })
        }
    }
}

#Preview {
    AuthenticationRootView()
        .environmentObject(AuthManager(service: MockAuthService()))
}
