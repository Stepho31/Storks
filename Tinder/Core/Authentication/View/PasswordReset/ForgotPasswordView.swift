//
//  ForgotPasswordView.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager
        
    @State private var email = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Your email?")
                    .bold()
                    .font(.title)
                
                Text("Enter the email associated with your account.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                VStack(spacing: 8) {
                    TextField("Enter email", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    Divider()
                }
                
                Spacer()
            }
            
            Button {
                onSendPasswordResetTap()
            } label: {
                Text("Send Password Reset")
                    .foregroundStyle(formIsValid ? .white : .black.opacity(0.5))
                    .bold()
                    .font(.title3)
                    .frame(width: 320, height: 50)
                    .background(formIsValid ? Color(.primaryPink) : Color(.systemGray5))
                    .clipShape(Capsule())
            }
        }
        .padding()
    }
}

private extension ForgotPasswordView {
    func onSendPasswordResetTap() {
        Task {
            await authManager.sendResetPasswordLink(toEmail: email)
            dismiss()
        }
    }
}

extension ForgotPasswordView: FormValidatorProtocol {
    var formIsValid: Bool {
        return email.isValidEmail()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(AuthManager(service: MockAuthService()))
            .preferredColorScheme(.dark)
    }
}
