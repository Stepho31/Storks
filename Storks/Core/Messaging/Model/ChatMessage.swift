//
//  Message.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/11/24.
//

import Firebase
import FirebaseFirestore

struct ChatMessage: Identifiable, Codable, Hashable {
    let id: String
    let fromId: String
    let toId: String
    let text: String
    let timestamp: Timestamp
    var read: Bool
//    let threadId: String 

    var user: User?
    
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
}
