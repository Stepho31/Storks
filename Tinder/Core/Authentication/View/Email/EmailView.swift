//
//  EmailView.swift
//  Tinder
//
//  Created by Brandon on 1/26/24.
//

import SwiftUI

struct EmailView: View {
    @State var email = ""
    
     var formIsValid: Bool {
         return email.isValidEmail()
    }
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                
                    BackButton()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Your email?")
                        .bold()
                        .font(.title)
                    
                    Text("Don't lose access to your account, add your email.")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    VStack(spacing: 10) {
                        TextField("Enter email", text: $email)
                        
                        Divider()
                            .frame(height: 1)
                            .opacity(0.5)
                    }
                }
                .padding(.horizontal, 28)
                
                Spacer()
                
                NavigationLink {
                    Text("Password View")
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
            }
            .navigationBarBackButtonHidden()
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
    }
}

extension EmailView: FormValidatorProtocol {
    
}

#Preview {
    EmailView()
}
