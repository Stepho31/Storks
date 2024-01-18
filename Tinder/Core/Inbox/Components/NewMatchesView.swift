//
//  NewMatchesView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/11/24.
//

import SwiftUI

struct NewMatchesView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("New Matches")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ..< 10) { index in
                        VStack {
                            Image(.lewisHamilton)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 88, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text("Lewis")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    NewMatchesView()
}
