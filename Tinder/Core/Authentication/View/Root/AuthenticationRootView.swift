//
//  AuthenticationRootView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/22/24.
//

import SwiftUI

struct AuthenticationRootView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var showAuthFlow = false
    
    var body: some View {
        NavigationStack {
            VStack {
                AuthenticationTopView()
                
                Spacer()
                
                AuthenticationBottomView()
            }
            .onChange(of: authManager.authType, perform: { value in
                showAuthFlow = value != nil
            })
            .fullScreenCover(isPresented: $showAuthFlow) {
                EmailView()
                    .environmentObject(authManager)
                    .environmentObject(authViewModel)
            }
        }
    }
}

#Preview {
    AuthenticationRootView()
        .environmentObject(AuthManager(service: MockAuthService()))
}
