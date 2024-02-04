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
    func saveMatch(withUser user: User, currentUser: User) async throws
}

struct MatchService: MatchServiceProtocol {
    func fetchMatches() async throws -> [Match] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        
        let snapshot = try await FirestoreConstants
            .UserCollection
            .document(currentUid)
            .collection("user-matches")
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Match.self) })
    }
    
    func checkForMatch(withUser user: User) async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await FirestoreConstants.UserLikesCollection(uid: user.id).document(currentUid).getDocument()
        return snapshot.exists
    }
    
    func saveMatch(withUser user: User, currentUser: User) async throws {
        let timestamp = Timestamp()

        let currentUserMatchRef = FirestoreConstants.UserCollection.document(currentUser.id).collection("user-matches").document()
        let currentUserMatch = Match(id: currentUserMatchRef.documentID, userId: user.id, matchTimestamp: timestamp)
        let currentUserMatchData = try Firestore.Encoder().encode(currentUserMatch)
        
        let userMatchRef = FirestoreConstants.UserCollection.document(user.id).collection("user-matches").document()
        let userMatch = Match(id: userMatchRef.documentID, userId: currentUser.id, matchTimestamp: timestamp)
        let userMatchData = try Firestore.Encoder().encode(userMatch)

        try await currentUserMatchRef.setData(currentUserMatchData)
        try await userMatchRef.setData(userMatchData)
    }
}
