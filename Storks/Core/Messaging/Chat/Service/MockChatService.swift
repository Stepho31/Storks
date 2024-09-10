//
//  MockChatService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Firebase
import FirebaseFirestore

class RealChatService: ChatServiceProtocol {
    private var firestoreListener: ListenerRegistration?
    private let db = Firestore.firestore()

    var chatPartner: User
    var currentUid: String

    init(chatPartner: User, currentUid: String) {
        self.chatPartner = chatPartner
        self.currentUid = currentUid
    }

    func observeChatMessages(forThread thread: Thread?) -> AsyncStream<ChatMessage> {
        guard let threadId = thread?.id else {
            return AsyncStream { continuation in continuation.finish() }
        }

        let query = db.collection("messages")
                      .whereField("threadId", isEqualTo: threadId)
                      .order(by: "timestamp")

        return AsyncStream { continuation in
            self.firestoreListener = query.addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    print("Error fetching messages: \(error?.localizedDescription ?? "Unknown error")")
                    continuation.finish()
                    return
                }

                snapshot.documentChanges.forEach { change in
                    if change.type == .added, let message = try? change.document.data(as: ChatMessage.self) {
                        continuation.yield(message)
                    }
                }
            }

            continuation.onTermination = { _ in
                self.firestoreListener?.remove()
            }
        }
    }
    
    func sendMessage(_ text: String, toThread thread: Thread?) async throws {
        guard let threadId = thread?.id else {
            // Handle the case where thread or threadId is nil
            throw NSError(domain: "AppError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid thread or user ID"])
        }

        let messageRef = db.collection("messages").document()
        let newMessage = ChatMessage(
            id: messageRef.documentID,
            fromId: self.currentUid,
            toId: chatPartner.id,
            text: text,
            timestamp: Timestamp(),
            read: false
//            threadId: threadId
        )

        do {
            try await messageRef.setData([
                "id": newMessage.id,
                "fromId": newMessage.fromId,
                "toId": newMessage.toId,
                "text": newMessage.text,
                "timestamp": newMessage.timestamp,
                "read": newMessage.read,
                "threadId": threadId
            ])
        } catch let error {
            print("Error sending message: \(error)")
            throw error
        }
    }
}


//struct MockChatService: ChatServiceProtocol {
//    func observeChatMessages(forThread thread: Thread?) -> AsyncStream<ChatMessage> {
//        AsyncStream { continuation in
//            DeveloperPreview.messages.forEach({ continuation.yield($0) })
//        }
//    }
//    
//    func sendMessage(_ message: String, toThread thread: Thread?) async throws {
//        let message = ChatMessage(
//            id: NSUUID().uuidString,
//            fromId: currentUid,
//            toId: chatPartner.id,
//            text: message,
//            timestamp: Timestamp(),
//            read: false
//        )
//        
//        DeveloperPreview.messages.append(message)
//    }
//    
//    
//    var chatPartner: User {
//        DeveloperPreview.users[1]
//    }
//    
//    var currentUid: String {
//        return DeveloperPreview.user.id
//    }
//}

