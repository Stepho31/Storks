//
//  InboxRowView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct InboxRowView: View {
    @EnvironmentObject var viewModel: InboxViewModel
    @EnvironmentObject var userManager: UserManager
    
    var chatPartner: User? {
        return thread.chatPartner
    }
    
    var message: ChatMessage? {
        return thread.lastMessage
    }
    
    let thread: Thread
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: chatPartner, size: .medium)
                        
            VStack(alignment: .leading, spacing: 4) {
                Text(chatPartner?.fullname ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                if let message {
                    Text("\(message.isFromCurrentUser ? "You: \(message.text)" : message.text)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing)
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            HStack {
                Text(thread.lastUpdated.dateValue().timestampString())
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .frame(maxHeight: 72)
        .swipeActions {
            withAnimation(.spring()) {
                Button { onDelete() } label: {
                    Image(systemName: "trash")
                }
                .tint(Color(.systemRed))
            }
        }
    }
}

private extension InboxRowView {
    func onDelete() {
        guard let currentUser = userManager.currentUser else { return }
        Task { try await viewModel.deleteThread(thread, currentUser: currentUser) }
    }
}

#Preview {
    InboxRowView(thread: DeveloperPreview.threads[0])
}
