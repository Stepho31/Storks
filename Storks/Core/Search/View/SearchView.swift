//
//  SearchView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/11/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var showPaywall = false
    @StateObject private var searchViewModel = SearchViewModel(service: SearchService())
    @EnvironmentObject private var userManager: UserManager
        
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Filters") {
                        Button("Parenting style") { onFilterTapped() }
                        Button("Child age") { onFilterTapped() }
                        Button("Lifestyle prefs") { onFilterTapped() }
                    }
                }
            }
            .sheet(isPresented: $showPaywall) { PaywallView() }
        }
    }
}

private extension SearchView {
    private var filteredUsers: [User] {
        let base: [User]
        if searchText.isEmpty {
            base = searchViewModel.users
        } else {
            let lowercasedQuery = searchText.lowercased()
            base = searchViewModel.users.filter({
                $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
        return base.sorted { lhs, rhs in
            let lhsRank = PlanGating.rank(for: lhs.plan ?? .free)
            let rhsRank = PlanGating.rank(for: rhs.plan ?? .free)
            if lhsRank != rhsRank { return lhsRank > rhsRank }
            return lhs.id < rhs.id
        }
    }

    func onFilterTapped() {
        // Gate advanced filters behind Plus or Premium
        let plan = userManager.currentUser?.plan ?? .free
        let entitlements = PlanGating.entitlements(for: plan)
        if !entitlements.advancedFilters {
            showPaywall = true
        }
    }
}

#Preview {
    SearchView()
}
