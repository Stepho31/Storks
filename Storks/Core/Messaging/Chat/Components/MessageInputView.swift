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
    @State private var showConcierge = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("Type a message", text: $messageText, axis: .vertical)
                .padding(12)
                .padding(.leading, 4)
                .padding(.trailing, 96)
                .background(Color(.secondarySystemBackground))
                .clipShape(Capsule())
            
            Spacer()
            
            HStack(spacing: 8) {
                Button {
                    showConcierge = true
                } label: {
                    Image(systemName: "wand.and.stars")
                        .padding(8)
                }
                .accessibilityLabel("Open concierge")
                
                Button("Send") { onSend() }
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .disabled(messageText.isEmpty)
                    .opacity(messageText.isEmpty ? 0.87 : 1.0)
            }
        }
        .font(.subheadline)
        .sheet(isPresented: $showConcierge) {
            ConciergePlannerView()
        }
    }
    
    private func onSend() {
        Task { 
            await chatManager.sendMessage(messageText)
            messageText = ""
        }
    }
}

//#Preview {
//    MessageInputView(
//        messageText: .constant(""),
//        chatManager: ChatManager(
//            service: RealChatService(chatPartner: <#User#>, currentUid: <#String#>),
//            thread: nil
//        )
//    )
//}
