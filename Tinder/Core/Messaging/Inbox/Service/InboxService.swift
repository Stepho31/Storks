//
//  InboxService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Firebase

protocol InboxServiceProtocol {
    func fetchThreads() async throws -> [Thread]
    func observeThreads() -> AsyncStream<Thread>
    func deleteThread(_ thread: Thread, currentUser: User) async throws
}

class InboxService: InboxServiceProtocol {
    private var firestoreListener: ListenerRegistration?
    private var threads = [Thread]()
    
    func observeThreads() -> AsyncStream<Thread> {
        return AsyncStream { continuation in
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            
            self.firestoreListener = FirestoreConstants
                .ThreadsCollection
                .whereField("uids", arrayContains: currentUid)
                .addSnapshotListener { [weak self] snapshot, _ in
                    guard let snapshot, let self else { return }
                    
                    let changes = snapshot.documentChanges.filter({
                        $0.type == .added || $0.type == .modified
                    })
                    
                    changes.compactMap{ try? $0.document.data(as: Thread.self) }
                        .filter({ !self.threads.contains($0) })
                        .forEach({ continuation.yield($0) })
                }
        }
    }
    
    func deleteThread(_ thread: Thread, currentUser: User) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { try await self.removeUserFromThread(thread, uid: uid) }
            group.addTask { try await self.deleteThreadIfNecessary(thread) }
        }
    }
    
    func fetchThreads() async throws -> [Thread] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }

        let snapshot = try await FirestoreConstants
            .ThreadsCollection
            .whereField("uids", arrayContains: currentUid)
            .getDocuments()
        
        self.threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
        return threads
    }
    
    deinit {
        self.firestoreListener?.remove()
        self.firestoreListener = nil
        
        print("DEBUG: Deinitializing inbox service")
    }
}

private extension InboxService {
    func removeUserFromThread(_ thread: Thread, uid: String) async throws {
        try await FirestoreConstants.ThreadsCollection.document(thread.id).updateData([
           "uids": FieldValue.arrayRemove([uid])
       ])
    }
    
    func deleteThreadIfNecessary(_ thread: Thread) async throws {
        if thread.uids.count == 1 {
            try await FirestoreConstants.ThreadsCollection.document(thread.id).delete()
        }
    }
}

