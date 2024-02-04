//
//  Match.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import Firebase

struct Match: Codable, Identifiable, Hashable {
    let id: String
    let userId: String
    let matchTimestamp: Timestamp
    
    var user: User?
}
