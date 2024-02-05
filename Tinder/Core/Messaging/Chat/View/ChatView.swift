//
//  ChatView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    @StateObject var chatManager: ChatManager
    private let user: User
    private let thread: Thread?
    
    init(user: User, thread: Thread?) {
        self.user = user
        self.thread = thread
        
        let chatService = ChatService(chatPartner: user, thread: thread)
        let manager = ChatManager(service: chatService, thread: thread)
        self._chatManager = StateObject(wrappedValue: manager)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(chatManager.messages) { message in
                        ChatMessageCell(message: message)
                    }
                }
            }
                        
            MessageInputView(messageText: $messageText, chatManager: chatManager)
                .padding(8)
        }
        .task(id: chatManager.initiateThreadObserver) {
            guard chatManager.initiateThreadObserver else { return }
            await chatManager.observeMessages()
        }
        .task { await chatManager.fetchThreadIfNecessary() }
        .navigationTitle(user.firstName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        ChatView(user: DeveloperPreview.users[1], thread: DeveloperPreview.thread)
    }
}
