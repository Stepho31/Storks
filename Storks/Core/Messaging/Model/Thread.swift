//
//  Thread.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Firebase
import FirebaseFirestore

struct Thread: Identifiable, Hashable, Codable {
    let id: String
    var uids: [String]
    var lastMessage: ChatMessage?
    var lastUpdated: Timestamp
    
    var chatPartner: User?
    
    var chatPartnerId: String {
        guard let currentUid = Auth.auth().currentUser?.uid else { return "" }
        return uids.filter({ $0 != currentUid }).first ?? ""
    }
}
