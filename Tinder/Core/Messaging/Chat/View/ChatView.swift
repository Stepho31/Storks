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
        
        let chatService = MockChatService()
        self._chatManager = StateObject(wrappedValue: ChatManager(service: chatService))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(DeveloperPreview.messages) { message in
                        ChatMessageCell(message: message)
                    }
                }
            }
                        
            MessageInputView(messageText: $messageText, chatManager: chatManager)
                .padding()
        }
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
