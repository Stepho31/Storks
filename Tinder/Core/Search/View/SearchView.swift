//
//  SearchView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/11/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(DeveloperPreview.users) { user in
                        UserCell(user: user)
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer)
        }
    }
}

#Preview {
    SearchView()
}
