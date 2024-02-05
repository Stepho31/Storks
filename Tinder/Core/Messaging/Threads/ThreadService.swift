//
//  ThreadService.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/4/24.
//

import Firebase

struct ThreadService {
    func createThread(withUser user: User) async throws -> Thread {
        guard let currentUid = Auth.auth().currentUser?.uid else { throw UserError.invalidUserId }
        let threadRef = FirestoreConstants.ThreadsCollection.document()
        
        let thread = Thread(
            id: threadRef.documentID,
            uids: [user.id, currentUid],
            lastMessage: nil,
            lastUpdated: Timestamp()
        )
        
        do {
            let threadData = try Firestore.Encoder().encode(thread)
            try await threadRef.setData(threadData)
            return thread
        } catch {
            throw error
        }
    }
    
    func fetchThread(withUser user: User) async throws -> Thread? {
        guard let currentUid = Auth.auth().currentUser?.uid else { return nil }
        
        let snapshot = try await FirestoreConstants
            .ThreadsCollection
            .whereField("uids", arrayContains: currentUid)
            .getDocuments()
        
        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
        return threads.first(where: { $0.uids.contains(user.id) })
    }
}
