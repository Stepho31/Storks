//
//  InboxListView.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/5/24.
//

import SwiftUI

struct InboxListView: View {
    @ObservedObject var viewModel: InboxViewModel
    
    var body: some View {
        Section {
            Text("Messages")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .listRowSeparator(.hidden)
                .offset(x: -10)
            
            ForEach(viewModel.threads) { thread in
                ZStack {
                    NavigationLink(value: thread) {
                        EmptyView()
                    }.opacity(0.0)
                    
                    InboxRowView(thread: thread, viewModel: viewModel)
                        .padding(.horizontal, 8)
                }
            }
            .listRowInsets(EdgeInsets())
            .padding(.vertical)
        }
    }
}

#Preview {
    InboxListView(viewModel: .init(service: InboxService()))
}
