//
//  SearchView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/11/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var searchViewModel = SearchViewModel(service: SearchService())
        
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(filteredUsers) { user in
                        NavigationLink(value: user) {
                            UserCell(user: user)
                        }
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                SocialUserProfileView(user: user)
            })
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer)
        }
    }
}

private extension SearchView {
    private var filteredUsers: [User] {
        if searchText.isEmpty {
            return searchViewModel.users
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return searchViewModel.users.filter({
                $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
    }
}

#Preview {
    SearchView()
}
