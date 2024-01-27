//
//  PasswordView.swift
//  Tinder
//
//  Created by Brandon on 1/27/24.
//

import SwiftUI

struct PasswordView: View, FormisValid {
    
    @State var password = ""
    @State var isSecure = true
    @State var isValid = false
    
    var formIsValid: Bool {
        get {
            return password.isValidPassword(password: password)
        }
    }
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .fontWeight(.heavy)
                            .foregroundStyle(.gray)
                            .opacity(0.6)
                    })
                    Spacer()
                }
                
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
            }
            .navigationBarBackButtonHidden()
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .alert("Password must be six characters", isPresented: $isValid) {
            Button(action: {
                
            }, label: {
                Button("OK", role: .cancel) {}
            })
        }
    }
}

#Preview {
    PasswordView()
}
