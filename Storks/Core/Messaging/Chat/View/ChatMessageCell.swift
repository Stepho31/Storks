//
//  ChatMessageCell.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct ChatMessageCell: View {
    let message: ChatMessage
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                
                Text(message.text)
                    .modifier(ChatBubbleModifier(isFromCurrentUser: true))
                    .overlay(alignment: .bottomTrailing) {
                        if PlanGating.entitlements(for: userManager.currentUser?.plan ?? .free).readReceipts {
                            HStack(spacing: 4) {
                                Image(systemName: message.read ? "checkmark.circle.fill" : "checkmark.circle")
                                    .foregroundStyle(message.read ? .blue : .gray)
                                Text(message.read ? "Read" : "Sent")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.trailing, 6)
                            .padding(.bottom, 2)
                        }
                    }
            } else {
                Text(message.text)
                    .modifier(ChatBubbleModifier(isFromCurrentUser: false))
                
                Spacer()
            }
        }
    }
}

#Preview {
    ChatMessageCell(message: DeveloperPreview.messages[3])
}
