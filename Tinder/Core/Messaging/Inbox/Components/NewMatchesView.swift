//
//  NewMatchesView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/11/24.
//

import SwiftUI

struct NewMatchesView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("New Matches")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(matchManager.matches) { match in
                        NavigationLink(value: match) {
                            NewMatchItemView(match: match)
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
