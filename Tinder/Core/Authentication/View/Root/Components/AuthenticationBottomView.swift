//
//  AuthenticationBottomView.swift
//  Tinder
//
//  Created by Brandon on 1/25/24.
//

import SwiftUI

struct AuthenticationBottomView: View {
    @Binding var authType: AuthenticationType?
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("By tapping 'Sign in' you agree to our Terms, Learn how we process your data in our Privacy Policy and Cookies Policy")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .foregroundColor(.white)
            
            Button(action: {
                authType = .createAccount
            }, label: {
                Text("Create Account")
                    .font(.headline)
                    .foregroundColor(.black).opacity(0.6)
                    .frame(width: 340, height: 50)
            })
            .background(.primary)
            .clipShape(Capsule())
            
            Button(action: {
                authType = .login
            }, label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
            })
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white, lineWidth: 1.5)
            )
            
            Button(action: {}, label: {
                Text("Trouble signing in?")
                    .bold()
                    .foregroundColor(.white)
            })
        }
        .padding(.horizontal, 30)
    }
}


#Preview {
    AuthenticationBottomView(authType: .constant(.login))
}
