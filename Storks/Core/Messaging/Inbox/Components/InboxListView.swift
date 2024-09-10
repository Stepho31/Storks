//
//  InboxListView.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/5/24.
//

import SwiftUI

struct InboxListView: View {
    @EnvironmentObject var viewModel: InboxViewModel
    
    var body: some View {
        Section {
            
            VStack(spacing: 0) {
                Text("Messages")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .listRowSeparator(.hidden)
                    .offset(x: -10)
                
                ForEach(viewModel.threads) { thread in
                    ZStack {
                        NavigationLink(value: thread) {
                            EmptyView()
                        }.opacity(0.0)
                        
                        InboxRowView(thread: thread)
                            .padding(.horizontal, 8)
                        Divider().hidden()
                    }
                    .padding(.vertical, -10)
                }
                .listRowSeparator(.hidden)
                .listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
                .padding(.vertical)
            }
            .listRowSeparator(.hidden)
        }
    }
}

#Preview {
    InboxListView()
        .environmentObject(
            InboxViewModel(
                service: MockInboxService(),
                userService: MockUserService()
            )
        )
}
