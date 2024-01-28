//
//  EmailView.swift
//  Tinder
//
//  Created by Brandon on 1/26/24.
//

import SwiftUI

struct EmailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager
    @State var email = ""
        
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Your email?")
                        .foregroundStyle(.white)
                        .bold()
                        .font(.title)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    VStack(spacing: 8) {
                        TextField("Enter email", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .foregroundStyle(.white)
                        
                        Divider()
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink {
                    PasswordView()
                } label: {
                    Text("Next")
                        .foregroundStyle(formIsValid ? .white : .black.opacity(0.5))
                        .bold()
                        .font(.title3)
                        .frame(width: 320, height: 50)
                        .background(formIsValid ? Color(.primaryPink) : Color(.systemGray5))
                        .clipShape(Capsule())
                }
                .disabled(!formIsValid)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            }
            .navigationBarBackButtonHidden()
            .padding()
            .background(.black)
        }
    }
}

private extension EmailView {
    var subtitle: String {
        guard let authType = authManager.authType else { return "" }
        
        switch authType {
        case .createAccount:
            return "Don't lose access to your account, add your email."
        case .login:
            return "Enter the email associated with your account to log back in"
        }
    }
}

private extension EmailView {
    var formIsValid: Bool {
        return email.isValidEmail() &&
        email.contains("bath.ac.uk")
    }
}

#Preview {
    EmailView()
        .environmentObject(AuthManager(service: MockAuthService()))
}
