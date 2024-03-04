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
            Image(.tinderLogoWhite)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 40)
                .padding()
            
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
        }
    }
}

#Preview {
    AuthenticationTopView()
        .preferredColorScheme(.dark)
}
