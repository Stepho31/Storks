//
//  MatchService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Firebase

protocol MatchServiceProtocol {
    func fetchMatches() async throws -> [Match]
    func checkForMatch(withUser user: User) async throws -> Bool
}

struct MatchService: MatchServiceProtocol {
    func fetchMatches() async throws -> [Match] {
        return []
    }
    
    func checkForMatch(withUser user: User) async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await FirestoreConstants.UserLikesCollection(uid: currentUid).document(user.id).getDocument()
        return snapshot.exists
    }
}
