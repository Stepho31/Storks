//
//  InboxView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct InboxView: View {
    var body: some View {
        NavigationStack {
            List {
                NewMatchesView()
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 8)
                
                VStack(alignment: .leading) {
                    Text("Messages")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    ForEach(DeveloperPreview.threads) { thread in
                        ZStack {
                            NavigationLink(value: thread) {
                                EmptyView()
                            }.opacity(0.0)
                            
                            InboxRowView(thread: thread)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listRowSeparator(.hidden)
            }
            .navigationDestination(for: Thread.self, destination: { thread in
                if let user = thread.chatPartner {
                    ChatView(user: user)
                }
            })
            .navigationTitle("Matches")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    NavigationStack {
        InboxView()
    }
}
