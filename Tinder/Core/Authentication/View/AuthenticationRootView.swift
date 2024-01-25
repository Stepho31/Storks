//
//  AuthenticationRootView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/22/24.
//

import SwiftUI

struct AuthenticationRootView: View {
    var body: some View {

        ZStack {
                gradient()
            
            VStack() {
                AuthenticationTopView()
                
                Spacer()
                
                AuthenticationBottomView()
            }
            .padding(.vertical, 50)
        }
        .ignoresSafeArea()
    }
    
    func gradient() -> LinearGradient {
        return LinearGradient(stops: [
            Gradient.Stop(color: Color(.pink), location: 0.1),
            Gradient.Stop(color: Color(.pink), location: 0.55),
        ], startPoint: .topTrailing, endPoint: .bottomLeading)
    }
}

#Preview {
    AuthenticationRootView()
}
