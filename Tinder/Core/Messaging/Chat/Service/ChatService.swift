//
//  ChatService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Firebase

protocol ChatServiceProtocol {
    func observeChatMessages() -> AsyncStream<Message>
    func sendMessage(_ message: String) async throws
    var chatPartner: User { get }
}

class ChatService: ChatServiceProtocol {
    private var firestoreListener: ListenerRegistration?
    
    private let threadId: String?
    var chatPartner: User
    
    private let initialFetchCount = 10
    
    init(chatPartner: User, threadId: String? ) {
        self.chatPartner = chatPartner
        self.threadId = threadId
    }
    
    func observeChatMessages() -> AsyncStream<Message> {
        AsyncStream { continuation in
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            guard let threadId else { return }
            
            let query = FirestoreConstants
                .ThreadsCollection
                .document(threadId)
                .collection("messages")
                .limit(toLast: initialFetchCount)
                .order(by: "timestamp", descending: false)
            
            query.addSnapshotListener { snapshot, _ in
                guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
                var messages = changes.compactMap{ try? $0.document.data(as: Message.self) }
                            
                for (index, message) in messages.enumerated() where message.fromId != currentUid {
                    messages[index].user = self.chatPartner
                }
                
                messages.forEach({ continuation.yield($0) })
            }
        }
    }
    
    func sendMessage(_ message: String) async throws {
        
    }
    
    deinit {
        self.firestoreListener?.remove()
        self.firestoreListener = nil
        
        print("DEBUG: Deinitializing chat service")
    }
}
