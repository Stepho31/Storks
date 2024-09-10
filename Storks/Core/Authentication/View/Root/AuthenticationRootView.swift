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
            .background(gradientBackground)
            .onChange(of: authManager.authType, { oldValue, newValue in
                showAuthFlow = newValue != nil
            })
            .fullScreenCover(isPresented: $showAuthFlow) {
                EmailView()
                    .environmentObject(authManager)
                    .environmentObject(authViewModel)
            }
        }
    }
}

private extension AuthenticationRootView {
    var gradientBackground: LinearGradient {
        LinearGradient(
            colors: [
                Color(.secondaryBlue),
                Color(.secondaryBlue),
                Color(.primaryBlue)
            ],
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
    }
}

#Preview {
    AuthenticationRootView()
        .environmentObject(AuthManager(service: MockAuthService()))
}
