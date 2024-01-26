//
//  LoginView.swift
//  Threads
//
//  Created by Stephan Dowless on 7/14/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
        self._viewModel = StateObject(wrappedValue: LoginViewModel(manager: authManager))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                // logo image
                Image("tinder-app-icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .padding()
                
                // text fields
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(TinderTextFieldModifier())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(TinderTextFieldModifier())
                }
                
                NavigationLink {
                    ForgotPasswordView()
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .foregroundColor(Color.theme.pink)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Button {
                    Task { try await viewModel.login() }
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .modifier(TinderButtonModifier())
                        
                }
                .padding(.vertical)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
//                    RegistrationView()
//                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color.theme.pink)
                    .font(.footnote)
                }
                .padding(.vertical, 16)

            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authManager: AuthManager(service: MockAuthService()))
    }
}
