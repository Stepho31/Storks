//
//  MessageInputView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct MessageInputView: View {
    @Binding var messageText: String
    @ObservedObject var chatManager: ChatManager
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("Type a message", text: $messageText, axis: .vertical)
                .padding(12)
                .padding(.leading, 4)
                .padding(.trailing, 48)
                .background(Color(.secondarySystemBackground))
                .clipShape(Capsule())
            
            Spacer()
            
            Button("Send") { 
                onSend()
            }
            .fontWeight(.semibold)
            .padding(.horizontal)
            .disabled(messageText.isEmpty)
            .opacity(messageText.isEmpty ? 0.87 : 1.0)
        }
        .font(.subheadline)
    }
    
    private func onSend() {
        Task { 
            await chatManager.sendMessage(messageText)
            messageText = ""
        }
    }
}

#Preview {
    MessageInputView(
        messageText: .constant(""),
        chatManager: ChatManager(
            service: MockChatService(),
            thread: nil
        )
    )
}
