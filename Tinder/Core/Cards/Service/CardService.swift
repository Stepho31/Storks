//
//  CardService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Firebase

protocol CardServiceProtocol {
    func fetchCards(for currentUser: User) async throws -> [CardModel]
    func saveLike(forUser user: User) async throws
}

struct CardService: CardServiceProtocol {
    func fetchCards(for currentUser: User) async throws -> [CardModel] {
        return []
    }
    
    func saveLike(forUser user: User) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        try await FirestoreConstants
            .UserCollection
            .document(currentUid)
            .collection("user-likes")
            .document(user.id)
            .setData([:])
    }
}
