//
//  InboxService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Firebase

class InboxService {
    private var firestoreListener: ListenerRegistration?
    
    func getThreadStream() -> AsyncStream<Thread> {
        AsyncStream(Thread.self) { continuation in
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            self.firestoreListener = FirestoreConstants
                .ThreadsCollection
                .whereField("uids", arrayContains: uid)
                .addSnapshotListener { snapshot, _ in
                    
                    guard let changes = snapshot?.documentChanges.filter({
                        $0.type == .added || $0.type == .modified
                    }) else { return }
                    
                    let threads = changes.compactMap{ try? $0.document.data(as: Thread.self) }
                    threads.forEach({ continuation.yield($0) })
                }
        }
    }
    
    deinit {
        self.firestoreListener?.remove()
        self.firestoreListener = nil
    }
}

