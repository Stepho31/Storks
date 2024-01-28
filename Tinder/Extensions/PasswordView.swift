//
//  PasswordView.swift
//  Tinder
//
//  Created by Brandon on 1/27/24.
//

import SwiftUI

struct PasswordView: View {
    
    @State var password = ""
    @State var isSecure = true
    @State var isValid = false
    
    var formIsValid: Bool {
        if password.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
        
                    BackButton()
                
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
                                SecureField("Enter password", text: $password)
                            } else {
                                TextField("Enter password", text: $password)
                            }
                            Spacer()
                            
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .onTapGesture {
                                    isSecure.toggle()
                                }
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .opacity(0.5)
                    }
                }
                .padding(.horizontal, 28)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Next")
                        .foregroundStyle(formIsValid ?  Color(.white) : Color(.black).opacity(0.5))
                        .bold()
                        .font(.title3)
                        .frame(width: 320, height: 50)
                        .background(formIsValid ?  Color(.primaryPink) : Color(.systemGray5))
                        .clipShape(Capsule())
                }
                .disabled(!formIsValid)
                .onTapGesture {
                    if !formIsValid {
                        isValid = true
                    } else {
                        isValid = false
                    }
                }
                .alert("Password must be six characters", isPresented: $isValid) {
                        Button("OK", role: .cancel) {}
                }
            }
        
            .navigationBarBackButtonHidden()
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
    }


extension PasswordView: FormValidatorProtocol {
    
}

#Preview {
    PasswordView()
}
