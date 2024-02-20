//
//  PasswordView.swift
//  Tinder
//
//  Created by Brandon on 1/27/24.
//

import SwiftUI

struct PasswordView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userManager: UserManager
    
    @State var isSecure = true
    @State var showAlert = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Your password?")
                    .bold()
                    .font(.title)
                
                Text("Don't lose access to your account, add your password.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                VStack(spacing: 10) {
                    HStack {
                        if isSecure {
                            SecureField("Enter password", text: $authViewModel.password)
                                .foregroundStyle(.white)
                        } else {
                            TextField("Enter password", text: $authViewModel.password)
                        }
                        
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .onTapGesture { isSecure.toggle() }
                    }
                    
                    Divider()
                }
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                onNext()
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
        .background(.black)
    }
}

private extension PasswordView {
    func onNext() {
        Task {
            await authManager.authenticate(
                withEmail: authViewModel.email,
                password: authViewModel.password
            )
            
            await userManager.fetchCurrentUser()
        }
    }
}

extension PasswordView: FormValidatorProtocol {
    var formIsValid: Bool {
        return authViewModel.password.count >= 6
    }
}

#Preview {
    NavigationStack {
        PasswordView()
    }
}
