//
//  ChatService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Firebase
import FirebaseFirestore


protocol ChatServiceProtocol {
    func observeChatMessages(forThread thread: Thread?) -> AsyncStream<ChatMessage>
    func sendMessage(_ message: String, toThread thread: Thread?) async throws
    var chatPartner: User { get }
}

class ChatService: ChatServiceProtocol {
    
    internal var chatPartner: User
    
    private var firestoreListener: ListenerRegistration?
    private let initialFetchCount = 100
    private var thread: Thread?
    
    init(chatPartner: User, thread: Thread?) {
        self.chatPartner = chatPartner
        self.thread = thread
    }
    
    deinit {
        print("DEBUG: Deinit chat service")
        firestoreListener?.remove()
        firestoreListener = nil
    }
    
    func observeChatMessages(forThread thread: Thread?) -> AsyncStream<ChatMessage> {
        self.thread = thread
        
        return AsyncStream { continuation in
            guard let query = chatQuery() else { return }

            onTerminationOfContinuation(continuation)
            
            self.firestoreListener = query.addSnapshotListener { [weak self] snapshot, _ in
                self?.streamMessages(fromSnapshot: snapshot, continuation: continuation)
            }
        }
    }
    
    func sendMessage(_ message: String, toThread thread: Thread?) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let thread = thread else { return }
        
        let messageRef = FirestoreConstants.ThreadsCollection.document()
        let messageId = messageRef.documentID
        
        let message = ChatMessage(
            id: messageId,
            fromId: currentUid,
            toId: chatPartner.id,
            text: message,
            timestamp: Timestamp(),
            read: false
        )
        
        do {
            try await uploadMessage(message, toThread: thread)
            try await updateLastThreadMessage(thread, message: message)
            print("Message sent and thread updated successfully.")
        } catch {
            print("Failed to send message or update thread: \(error)")
            throw error
        }
    }
}

private extension ChatService {
    func uploadMessage(_ message: ChatMessage, toThread thread: Thread) async throws {
        let messageData = try Firestore.Encoder().encode(message)

        try await FirestoreConstants
            .ThreadsCollection
            .document(thread.id)
            .collection("messages")
            .document(message.id)
            .setData(messageData)
    }
    
//    func updateLastThreadMessage(_ thread: Thread, message: ChatMessage) async throws {
//        let messageData = try Firestore.Encoder().encode(message)
//
//        try await FirestoreConstants
//            .ThreadsCollection
//            .document(thread.id)
//            .updateData([
//            "lastMessage": messageData,
//            "lastUpdated": Timestamp()
//        ])
//    }
    
    func updateLastThreadMessage(_ thread: Thread, message: ChatMessage) async throws {
        let messageData: [String: Any] = [
            "id": message.id,
            "fromId": message.fromId,
            "toId": message.toId,
            "text": message.text,
            "timestamp": message.timestamp,
            "read": message.read
        ]

        try await Firestore.firestore().collection("threads")
            .document(thread.id)
            .updateData([
                "lastMessage": messageData,
                "lastUpdated": FieldValue.serverTimestamp() // Use server timestamp for consistency
            ])
    }
    
    func chatQuery() -> Query? {
        guard let threadId = thread?.id else { return nil }
        
        return FirestoreConstants
            .ThreadsCollection
            .document(threadId)
            .collection("messages")
            .limit(toLast: initialFetchCount)
            .order(by: "timestamp", descending: false)
    }
    
    func streamMessages(fromSnapshot snapshot: QuerySnapshot?, continuation: AsyncStream<ChatMessage>.Continuation) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
        
        var messages = changes.compactMap{ try? $0.document.data(as: ChatMessage.self) }
        
        for (index, message) in messages.enumerated() where message.fromId != currentUid {
            messages[index].user = self.chatPartner
        }
        
        messages.forEach({ continuation.yield($0) })
    }
    
    func onTerminationOfContinuation(_ continuation: AsyncStream<ChatMessage>.Continuation) {
        continuation.onTermination = { _ in
            self.firestoreListener?.remove()
            self.firestoreListener = nil
            continuation.finish()
        }
    }
}
