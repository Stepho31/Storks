//
//  ToolbarLogo.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import SwiftUI

struct ToolbarLogo: View {
    var body: some View {
//        Image(.tinderLogo)
//            .resizable()
//            .scaledToFill()
//            .frame(width: 88)
        
        Text("AURORA")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
    }
}

#Preview {
    ToolbarLogo()
}
