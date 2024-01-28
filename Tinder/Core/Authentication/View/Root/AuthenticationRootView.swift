//
//  AuthenticationRootView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/22/24.
//

import SwiftUI

struct AuthenticationRootView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            AuthenticationTopView()
            
            Spacer()
            
            AuthenticationBottomView(authType: $authManager.authType)
        }
        .fullScreenCover(item: $authManager.authType, content: { _ in
            EmailView()
                .environmentObject(authManager)
        })
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AuthenticationRootView()
        .environmentObject(AuthManager(service: MockAuthService()))
}
