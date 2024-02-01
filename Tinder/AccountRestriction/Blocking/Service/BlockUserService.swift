//
//  BlockUserService.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/1/24.
//

import Firebase

protocol BlockUserServiceProtocol {
    func blockUser(_ user: User) async throws
}

struct BlockUserService: BlockUserServiceProtocol {
    
    func blockUser(_ user: User) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                try await FirestoreConstants.UserCollection.document(currentUid).updateData([
                    "blockedUIDs": FieldValue.arrayUnion([user.id])
                ])
            }
            
            group.addTask {
                try await FirestoreConstants.UserCollection.document(user.id).updateData([
                    "blockedByUIDs": FieldValue.arrayUnion([currentUid])
                ])
            }
        }
    }
    
}
