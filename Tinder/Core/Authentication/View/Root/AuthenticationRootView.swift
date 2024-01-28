//
//  AuthenticationRootView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/22/24.
//

import SwiftUI

struct AuthenticationRootView: View {
    @State private var authType: AuthenticationType?
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            AuthenticationTopView()
            
            Spacer()
            
            AuthenticationBottomView(authType: $authType)
        }
        .onChange(of: authType, perform: { value in
            authManager.authType = value
        })
        .sheet(item: $authType, content: { _ in
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
