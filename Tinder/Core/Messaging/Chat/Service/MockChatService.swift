//
//  MockChatService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Firebase

struct MockChatService: ChatServiceProtocol {
    func observeChatMessages(forThread thread: Thread?) -> AsyncStream<Message> {
        AsyncStream { continuation in
            DeveloperPreview.messages.forEach({ continuation.yield($0) })
        }
    }
    
    func sendMessage(_ message: String, toThread thread: Thread?) async throws {
        let message = Message(
            id: NSUUID().uuidString,
            fromId: currentUid,
            toId: chatPartner.id,
            text: message,
            timestamp: Timestamp(),
            read: false
        )
        
        DeveloperPreview.messages.append(message)
    }
    
    
    var chatPartner: User {
        DeveloperPreview.users[1]
    }
    
    var currentUid: String {
        return DeveloperPreview.user.id
    }
}
