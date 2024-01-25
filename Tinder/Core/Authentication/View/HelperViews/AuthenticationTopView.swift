//
//  AuthenticationTopView.swift
//  Tinder
//
//  Created by Brandon on 1/25/24.
//

import SwiftUI

struct AuthenticationTopView: View {
    var body: some View {
        VStack {
            Image("tinder-logo-white")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
   
            VStack(spacing: 8) {
                HStack {
                    Text("It Starts")
                        .bold()
                    
                    Text("with")
                    
                }
                HStack {
                    Text("a")
                    
                    Text("Swipe")
                        .bold()
                }
            }
            .font(.largeTitle)
            .foregroundStyle(.white)
            .frame(width: 210)
            
            Spacer()
        }
    }
}

#Preview {
    AuthenticationTopView()
}
