//
//  Thread.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Firebase

struct Thread: Identifiable, Hashable, Codable {
    let id: String
    let uids: [String]
    var lastMessage: Message
    var imageUrl: String?
    var lastUpdated: Timestamp
    
    var chatPartner: User?
}
