//
//  InboxView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct InboxView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    @StateObject var inboxViewModel = InboxViewModel(
        service: InboxService(),
        userService: UserService()
    )
    
    var body: some View {
        NavigationStack {
            List {
                NewMatchesView()
                
                switch inboxViewModel.loadingState {
                case .loading:
                    InboxLoadingView()
                case .empty:
                    InboxEmptyStateView()
                case .hasData:
                    InboxListView()
                        .environmentObject(inboxViewModel)
                }
            }
            .listStyle(PlainListStyle())
            .navigationDestination(for: Thread.self, destination: { thread in
                if let user = thread.chatPartner {
                    ChatView(user: user, thread: thread)
                }
            })
            .navigationDestination(for: Match.self, destination: { match in
                if let user = match.user {
                    ChatView(user: user, thread: nil)
                }
            })
            .navigationTitle("Matches")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(PlainListStyle())
        }
        .task { await matchManager.fetchMatches() }
    }
}

#Preview {
    NavigationStack {
        InboxView()
    }
}
