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
        HStack(alignment: .center, spacing: 12) {
            // Profile Image
            CircularProfileImageView(user: chatPartner, size: .medium)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .shadow(radius: 2) // Enhanced shadow for depth
            
            // Content Stack
            VStack(alignment: .leading, spacing: 4) {
                // Name and date horizontally
                HStack {
                    Text(chatPartner?.fullname ?? "Unknown User")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(thread.lastUpdated.dateValue().timestampString())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Last message preview
//                if let message = message {
//                    Text("\(message.isFromCurrentUser ? "You: \(message.text)" : message.text)")
//                        .font(.footnote)
//                        .foregroundColor(.gray)
//                        .lineLimit(2)
//                        .truncationMode(.tail)
//                } else {
//                    Text("No messages yet")
//                        .italic()
//                        .foregroundColor(.secondary)
//                }
//            }
                if let message = thread.lastMessage {
                    Text("\(message.isFromCurrentUser ? "You: \(message.text)" : message.text)")
                                   .font(.footnote)
                                   .foregroundColor(.gray)
                                   .lineLimit(2)
                                   .truncationMode(.tail)
                           } else {
                               Text("No messages yet")
                                   .italic()
                                   .foregroundColor(.secondary)
                           }
                       }
            .frame(maxWidth: .infinity, alignment: .leading)
            
//            // Chevron icon
//            Image(systemName: "chevron.right")
//                .foregroundColor(.secondary)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(.primaryBlue), Color(UIColor.systemGray6)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(10)
        .shadow(radius: 3) // Softer shadow for a subtle depth effect
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)  // Add a border to enhance frame visibility
        )
        .swipeActions {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .animation(.easeInOut, value: message)  // Add a gentle animation on message update
    }
    
    private func onDelete() {
        guard let currentUser = userManager.currentUser else { return }
        Task {
            try await viewModel.deleteThread(thread, currentUser: currentUser)
        }
    }
}

// Preview Provider
struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView(thread: DeveloperPreview.thread)
            .environmentObject(InboxViewModel(service: MockInboxService(), userService: MockUserService()))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
