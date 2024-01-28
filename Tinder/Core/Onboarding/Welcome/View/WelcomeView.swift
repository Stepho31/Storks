//
//  WelcomeView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/23/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Image(.tinderAppIcon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                
                Text("Welcome to Aurora.")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("Please follow these House Rules.")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            WelcomeInfoItemView(title: "Be Yourself.", subtitle: "Make sure your photos, age, and bio are true to who you are.")
            
            WelcomeInfoItemView(title: "Stay safe.", subtitle: "Don't be too quick to give our personal information.")

            WelcomeInfoItemView(title: "Play it cool.", subtitle: "Respect others and treat them as you would like to be treated.")

            WelcomeInfoItemView(title: "Be proactive.", subtitle: "Always report bad behavior..")
            
            Spacer()
            
            Button {
                print("DEBUG: Handle agree to terms")
            } label: {
                Text("I agree")
                    .modifier(TinderButtonModifier())
            }

        }
        .padding()
        .background(.black)
    }
}

#Preview {
    WelcomeView()
}
