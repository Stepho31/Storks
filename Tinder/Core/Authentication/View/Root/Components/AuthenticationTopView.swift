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
            Text("AURORA")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
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
